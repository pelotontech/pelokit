require 'pelokit/concerns/rest_request'

module Pelokit
  class PendingClient < RequestBase

    include Pelokit::RestRequest

    self.restful_resource = 'pendingclients'

    def initialize(token)
      @id = token
    end

    def get
      get_request
    end

  end
end
