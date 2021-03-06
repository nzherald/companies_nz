require 'uri'
require 'json'

module CompaniesNZ
  class Client
    attr_reader :signer, :http_client

    def initialize(options = {})
      @base_url = options.fetch(:test, false) ? TEST_URL : URL
      @signer = HMACSigner.new(key_id: options.fetch(:key_id),
                               secret_key: options.fetch(:secret_key),
                               base_url: @base_url)
      @http_client = Faraday.new(url: @base_url)
    end

    def search_entities(query)
      query = URI.encode(query)
      response = perform_request "/data/app/ws/rest/companies/entity/search/v2.0/#{query}"
      JSON.parse(response.body)
    end

    def search_roles(query)
      query = URI.encode(query)
      response = perform_request "/data/app/ws/rest/companies/role/search/v1.0/#{query}"
      JSON.parse(response.body)
    end

    def entity_details(company_number)
      query = URI.encode(company_number.to_s)
      response = perform_request "/data/app/ws/rest/companies/entity/v2.0/#{query}"
      JSON.parse(response.body)
    end

    private

    def perform_request(url)
      http_client.get(url) do |req|
        req.headers['Accept'] = 'application/json'
        req.headers['Date'] = signer.formatted_time
        req.headers['Authorization'] = signer.generate_header(http_method: 'GET', url: url)
      end
    end
  end
end
