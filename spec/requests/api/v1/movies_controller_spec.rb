require 'rails_helper'

describe 'Api V1 MoviesController', type: :request do
  context 'when user requests all the movies' do
    let!(:movies) { create_list(:movie, 10) }

    context 'without genres' do
      it 'returns correct quantity of movies' do
        get '/api/v1/movies'
        response = JSON.parse(@response.body)

        expect(response['movies']['data'].length).to eq(10)
      end
    end

    context 'with genres' do
      it 'contains the genres enlisted' do
        get '/api/v1/movies', params: { serialize_genre: true }
        response = JSON.parse(@response.body)

        expect(response['movies']['data'].length).to eq(10)
        expect(response['movies']).to have_key('included')
      end
    end
  end

  context 'when user requests one movie' do
    let!(:movie) { create(:movie) }

    context 'without genres' do
      it 'returns one record' do
        get "/api/v1/movies/#{movie.id}"
        response = JSON.parse(@response.body)

        expect(response['movie']['data']['attributes']['id']).to eq(movie.id)
        expect(response['movie']['data']['attributes']['title']).to eq(movie.title)
      end
    end

    context 'with genres' do
      it 'returns one record with genre' do
        get "/api/v1/movies/#{movie.id}", params: { serialize_genre: true }
        response = JSON.parse(@response.body)

        expect(response['movie']['data']['attributes']['id']).to eq(movie.id)
        expect(response['movie']['data']['attributes']['title']).to eq(movie.title)
        expect(response['movie']).to have_key('included')
        expect(response['movie']['included'][0]['attributes']['name']).to eq(movie.genre.name)
      end
    end
  end
end
