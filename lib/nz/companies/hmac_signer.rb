require 'base64'
require 'openssl'

module NZ
  module Companies
    class HMACSigner
      attr_reader :key_id, :base_url

      def initialize(options = {})
        @key_id = options.fetch(:key_id)
        @secret_key = options.fetch(:secret_key)
        @base_url = options.fetch(:base_url)
      end

      def generate_header(options)
        '"' + key_id + ':' + sign(template(options)) + '"'
      end

      def sign(data)
        digest = OpenSSL::Digest.new('sha256')
        result = OpenSSL::HMAC.digest(digest, secret_key, data)
        Base64.encode64 result
      end

      def template(options)
        http_method, url = options.fetch(:http_method), options.fetch(:url)
        "#{http_method}\n#{base_url}\n#{url}\n#{formatted_time}\n#{key_id}\napplication/json\n"
      end

      def formatted_time
        # Spec states time should be in RFC1123 format
        Time.now.strftime('%a, %e %b %Y %H:%M:%S %z')
      end
    end
  end
end
