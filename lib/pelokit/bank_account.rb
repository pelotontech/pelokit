require 'hashie'
require 'pelokit/concerns/request'

module Pelokit
  class BankAccount < Hashie::Dash

    include Pelokit::Request

    property :bank_account_id
    property :bank_account_name
    property :bank_account_owner
    property :bank_account_type_code
    property :financial_insitution_number
    property :branch_transit_number
    property :account_number
    property :currency_code
    property :verify_account_by_deposit

    def add
      response = request :add_bank_account, :addBankAccountRequest
      response
    end

    def update
      request :modify_bank_account, :modifyBankAccountRequest
    end

  end
end
