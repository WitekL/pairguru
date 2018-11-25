module Api
  module V1
    class MoviesController < ::Api::V1::BaseController
      def index
        movies = Movie.all

        render json: { movies: serialize_payload(movies) }
      end

      def show
        movie = Movie.find(params[:id])

        render json: { movie: serialize_payload(movie) }
      end

      private

      def serialize_payload(resource)
        MovieSerializer.new(resource, serialization_options).serializable_hash
      end

      def serialization_options
        return { include: [:genre] } if params[:serialize_genre]

        {}
      end
    end
  end
end
