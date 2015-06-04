require 'active_support/all'
require 'savon'

module Pelokit
  module Request
    extend ActiveSupport::Concern

    LOG = true

    private
    def options
      options = { }
      options.merge! self.to_hash
      options.merge! Pelokit::api_args

      # Camelize the hash keys for the request.
      options = options.inject({}) do |opts, (k,v)|
        opts[k.to_s.camelize] = v.to_s
        opts
      end
      options
    end

    def request(method, type)
      # Invoke the method; include a request wrapper.
      response = client.call(method, message: { type => options })
      response
    rescue Savon::SOAPFault, Savon::HTTPError => error
      raise error
    end

    def client
      @client ||= Savon.client(pretty_print_xml: LOG) do
        wsdl(Pelokit.wsdl)
      end
    end

  end
end
