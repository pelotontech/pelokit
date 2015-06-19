require 'active_model'
require 'hashie'
require 'pelokit/concerns/transport/soap'

module Pelokit
  class ElectronicFundsTransfer < RequestBase

    include Pelokit::Transport::Soap
    include ActiveModel::Validations

    property :bank_account_id
    property :amount
    property :transfer_date

    validates :bank_account_id, presence: true
    validates :amount,          presence: true, format: { with: /\A\d+(?:\.\d{0,2})?\z/ }
    validates :transfer_date,   presence: true


    def deposit
      # a = Pelokit::ElectronicFundsTransfer.new bank_account_id: 'ZZZZZZ', amount: '34.34', transfer_date: '2015-07-01'
      request :deposit_funds, :eftRequest
    end

  end
end
