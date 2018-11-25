require 'rails_helper'

describe NetguruAPI::V1::Client do
  context 'while sending request for one movie' do
    let(:movie) { Movie.new(title: 'Kill Bill') }
    let(:invalid_movie) { Movie.new(title: 'Titanic') }

    it 'returns the movie info if it exists' do
      data = subject.single_movie_info(movie.title)
      plot = data.dig(movie.title, 'data', 'attributes', 'plot')

      expect(plot).not_to be_nil
    end

    it 'returns nil if it does not exis' do
      data = subject.single_movie_info(invalid_movie.title)
      plot = data.dig(movie.title, 'data', 'attributes', 'plot')

      expect(plot).to be_nil
    end
  end

  context 'while sending request for multiple movies' do
    let(:first_movie) { Movie.new(title: 'Kill Bill') }
    let(:second_movie) { Movie.new(title: 'Deadpool') }
    let(:movie_array) { [first_movie, second_movie].map(&:title) }

    it 'returns the movie info if it exists' do
      data = subject.movies_info(movie_array)
      first_plot = data[first_movie.title].dig('data', 'attributes', 'plot')
      second_plot = data[second_movie.title].dig('data', 'attributes', 'plot')

      expect(first_plot).not_to be_nil
      expect(second_plot).not_to be_nil
    end
  end
end
