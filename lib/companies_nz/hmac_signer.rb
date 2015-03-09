require 'base64'
require 'openssl'
require 'uri'

module CompaniesNZ
  class HMACSigner
    attr_reader :key_id, :base_url

    def initialize(options = {})
      @key_id = options.fetch(:key_id)
      @secret_key = options.fetch(:secret_key)
      @base_url = URI.parse(options.fetch(:base_url))
    end

    def generate_header(options)
      key_id + ':' + sign(template(options))
    end

    def sign(data)
      digest = OpenSSL::Digest.new('sha256')
      result = OpenSSL::HMAC.digest(digest, @secret_key, data)
      Base64.encode64 result
    end

    def template(options)
      http_method, url = options.fetch(:http_method), options.fetch(:url)
      "#{http_method}\n#{base_url.host}\n#{url}\n#{formatted_time}\n#{key_id}\napplication/json\n"
    end

    def formatted_time
      # Spec states time should be in RFC1123 format
      Time.now.gmtime.strftime('%a, %e %b %Y %H:%M:%S %z').sub(/ \+0000$/, ' GMT')
    end
  end
end
