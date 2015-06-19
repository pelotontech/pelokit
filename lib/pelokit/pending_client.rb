require 'pelokit/concerns/transport/rest'

module Pelokit
  class PendingClient < RequestBase

    include Pelokit::Transport::Rest

    self.restful_resource = 'pendingclients'

    def initialize(token)
      @id = token
    end

    def get
      get_request
    end

  end
end
