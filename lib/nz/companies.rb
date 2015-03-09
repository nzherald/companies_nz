require 'nz/companies/version'

module NZ
  module Companies
    URL = 'http://www.businessdata.govt.nz'
    TEST_URL = 'http://www.eat.business.govt.nz'
  end
end

%w[client hmac_signer http_client].each { |f| require "nz/companies/#{f}" }
