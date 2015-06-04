require 'hashie'
require 'pelokit/concerns/request'

module Pelokit
  class ElectronicFundsTransfer < Hashie::Dash

    include Pelokit::Request

    property :bank_account_id
    property :amount
    property :transfer_date

    def deposit
      # a = Pelokit::ElectronicFundsTransfer.new bank_account_id: 'ZZZZZZ', amount: '34.34', transfer_date: '2015-07-01'
      request :deposit_funds, :eftRequest
    end

  end
end
