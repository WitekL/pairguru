class GenresController < ApplicationController
  def index
    @genres = Genre.all.decorate
  end

  def movies
    resource = Genre.find(params[:id])
    data = fetch_multiple_movies(titles(resource.movies))

    @genre = resource.decorate(context: data)
  end
end
