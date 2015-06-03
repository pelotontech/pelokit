require "pelokit/version"
require "pelokit/bank_account"
# require "pelokit/mixins/peloton_request"

module Pelokit
  @wsdl = 'http://test.peloton-technologies.com/EppBanking.asmx?WSDL'

  class << self
    attr_writer   :client_id, :account_name, :password
    attr_accessor :wsdl

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
