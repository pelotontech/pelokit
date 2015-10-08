require 'pelokit/version'

module Pelokit
  @wsdl = 'http://test.peloton-technologies.com/EppBanking.asmx?WSDL'
  @rest = 'https://testapi.peloton-technologies.com/v1'

  class << self
    attr_writer   :client_id, :account_name, :password
    attr_accessor :wsdl, :rest

    def configure(&block)
      yield self
    end

    def api_args
      { client_id:        @client_id,
        account_name:     @account_name,
        password:         @password,
        application_name: "#{self.name.downcase} #{VERSION}" }
    end
  end

end

require 'pelokit/request_base'
require 'pelokit/bank_account'
require 'pelokit/electronic_funds_transfer'
require 'pelokit/pending_client'
