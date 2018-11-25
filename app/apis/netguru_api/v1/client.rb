module NetguruAPI
  module V1
    class Client
      API_ENDPOINT = 'https://pairguru-api.herokuapp.com/'.freeze

      def single_movie_info(title)
          slug = slugify_title(title)

          request = prepare_request(
            http_method: :get,
            endpoint: "#{API_ENDPOINT}/api/v1/movies/#{slug}"
          )

          request.run
          { title => JSON.parse(request.response.body) }
      end

      def movies_info(titles)
        requests = titles.map do |title|
          slug = slugify_title(title)

          prepare_request(
            http_method: :get,
            endpoint: "#{API_ENDPOINT}/api/v1/movies/#{slug}"
          )
        end

        parallelize_requests(requests)
        responses = prepare_responses(requests)

        Hash[titles.zip(responses)]
      end

      private

      def prepare_request(endpoint:, http_method:, params: {})
        Typhoeus::Request.new(
          endpoint,
          method: http_method,
        )
      end

      def parallelize_requests(requests)
        hydra = Typhoeus::Hydra.hydra

        requests.each do |request|
          hydra.queue(request)
        end

        hydra.run
      end

      def prepare_responses(requests)
        requests.reject { |request| request.response.response_code != 200 }

        requests.map { |request| JSON.parse(request.response.body) }
      end

      def slugify_title(title)
        title.gsub(/\s+/, '%20')
      end
    end
  end
end
