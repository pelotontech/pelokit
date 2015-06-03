require 'active_support/all'
require 'savon'

module Pelokit
  module Request
    extend ActiveSupport::Concern

    private
    def options
      options = { }
      options.merge! self.to_hash
      options.merge! Pelokit::api_args

      # Camelize the hash keys for the request.
      options = options.inject({}) do |opts, (k,v)|
        opts[k.to_s.camelize] = v
        opts
      end
      options
    end

    def request(method)
      # Invoke the method; include a request wrapper.
      response = client.call(method,
                             message: { "#{method.to_s.camelize(:lower)}Request" => options })
      response
    rescue Savon::SOAPFault, Savon::HTTPError => error
      raise error
    end

    def client
      @client ||= Savon.client do
        wsdl(Pelokit.wsdl)
      end
    end

  end
end
