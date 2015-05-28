require 'savon'
require 'hashie'

module Pelokit
  class BankAccount < Hashie::Dash

    property :bank_account_id
    property :bank_account_name
    property :bank_account_owner
    property :bank_account_type_code
    property :financial_insitution_number
    property :branch_transit_number
    property :account_number
    property :currency_code
    property :verify_account_by_deposit

    def add
      request :add_bank_account
    end

    private
    def request(method)
      options = { }
      options.merge! self.to_hash
      options.merge! Pelokit::api_args

      # Camelize the hash keys for the request.
      options = options.inject({}) do |opts, (k,v)|
        opts[k.to_s.camelize] = v
        opts
      end

      # Invoke the method; include a request wrapper.
      response = client.call(method,
                             message: { "#{method.to_s.camelize(:lower)}Request" => options })
      response
    rescue Savon::SOAPFault, Savon::HTTPError => error
      raise error
    end

    def client
      @client ||= Savon.client do
        wsdl(Pelokit::WSDL)
      end
    end

  end
end
