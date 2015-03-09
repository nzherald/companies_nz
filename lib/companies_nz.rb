require 'companies_nz/version'
require 'faraday'

%w[client hmac_signer].each { |f| require "companies_nz/#{f}" }

module CompaniesNZ
  URL = 'http://www.businessdata.govt.nz'
  TEST_URL = 'http://www.eat.business.govt.nz'
end

