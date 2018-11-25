class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception
  before_action :configure_permitted_parameters, if: :devise_controller?

  protected

  def configure_permitted_parameters
    added_attrs = [:name, :email, :password, :password_confirmation]
    devise_parameter_sanitizer.permit :sign_up, keys: added_attrs
    devise_parameter_sanitizer.permit :account_update, keys: added_attrs
  end

  def titles(resource)
    resource.map(&:title)
  end

  def fetch_multiple_movies(movie_titles)
    NetguruAPI::V1::Client.new.movies_info(movie_titles)
  end

  def fetch_single_movie(movie_title)
    NetguruAPI::V1::Client.new.single_movie_info(movie_title)
  end
end
