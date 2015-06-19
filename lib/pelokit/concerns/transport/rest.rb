require 'httparty'
require 'ostruct'

module Pelokit
  module Transport
    module Rest
      extend ActiveSupport::Concern

      included do |base|
        base.class_attribute :restful_resource
      end

      class RestError < Exception; end

      attr_accessor :id

      private
      def get_request
        response = HTTParty.get("#{Pelokit.rest}/#{self.restful_resource}/#{@id}", basic_auth: { username: client_id,
                                                                                   password: password })

        raise RestError.new "#{response.code} #{response.message}" unless response.code == 200
        obj = OpenStruct.new response.parsed_response
        obj
      end

      def delete_request
        response = HTTParty.delete("#{Pelokit.rest}/#{self.restful_resource}/#{@id}", basic_auth: { username: client_id,
                                                                                  password: password })

        raise RestError.new "#{response.code} #{response.message}" unless response.code == 200
        obj = OpenStruct.new response.parsed_response
        obj
      end

      def client_id
        @client_id || Pelokit.api_args[:client_id]
      end

      def password
        @password || Pelokit.api_args[:password]
      end

    end
  end
end
