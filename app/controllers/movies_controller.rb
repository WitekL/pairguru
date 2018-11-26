class MoviesController < ApplicationController
  before_action :authenticate_user!, only: [:send_info]

  def index
    resource = Movie.all
    data = fetch_multiple_movies(titles(resource))

    @movies = resource.decorate(context: data)
  end

  def show
    resource = Movie.find(params[:id])
    data = fetch_single_movie(resource.title)

    @movie = resource.decorate(context: data)
  end

  def send_info
    @movie = Movie.find(params[:id])
    MovieInfoMailer.send_info(current_user, @movie).deliver_later

    redirect_back(fallback_location: root_path, notice: "Email sent with movie info")
  end

  def export
    file_path = "tmp/movies.csv"
    ExportCsvJob.perform_later(current_user, file_path)

    redirect_to root_path, notice: "Movies exported"
  end
end
