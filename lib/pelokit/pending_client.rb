require 'httparty'
require 'ostruct'

module Pelokit
  class PendingClient

    class RestError < Exception; end

    include HTTParty
    base_uri Pelokit.rest

    attr_writer :client_id, :password

    def initialize(token)
      @token = token
    end

    def get
      response = self.class.get("/pendingclients/#{@token}", basic_auth: { username: client_id,
                                                                           password: password })

      raise RestError.new "#{response.code} #{response.message}" unless response.code == 200
      obj = OpenStruct.new response.parsed_response
      obj
    end

    private
    def client_id
      @client_id || Pelokit.api_args[:client_id]
    end

    def password
      @password || Pelokit.api_args[:password]
    end
  end
end
