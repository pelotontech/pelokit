require 'hashie'

module Pelokit
  class SoapBase < Hashie::Dash
    # These properties are overridable by requests.
    # If not set, the Pelokit defined options are used.
    property :client_id
    property :password
    property :account_name
  end
end
