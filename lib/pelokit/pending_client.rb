require 'pelokit/concerns/rest_request'

module Pelokit
  class PendingClient

    include Pelokit::RestRequest

    self.restful_resource = 'pendingclients'

    def initialize(token)
      @id = token
    end

    def get
      get_request
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
