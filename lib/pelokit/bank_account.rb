require 'active_model'
require 'hashie'
require 'pelokit/concerns/transport/soap'
require 'pelokit/concerns/transport/rest'

module Pelokit
  class BankAccount < RequestBase

    include Pelokit::Transport::Soap
    include ActiveModel::Validations

    include Pelokit::Transport::Rest
    self.restful_resource = 'BankAccount'

    property :bank_account_id, default: ''
    property :bank_account_name
    property :bank_account_owner
    property :bank_account_type_code
    property :financial_insitution_number
    property :branch_transit_number
    property :account_number
    property :currency_code,             default: 'CAD'
    property :verify_account_by_deposit, default: '1'

    validates :bank_account_id, length: { minimum:   0,
                                          maximum:   32,
                                          allow_nil: false,
                                          message:   "must be non-nil and length <= 32" }

    validates :bank_account_name, presence: true

    validates :financial_insitution_number, presence: true,
                                            length:   { maximum: 3 },
                                            format:   { with: /\A[0-9]+\z/, message: "must be numeric" }

    validates :branch_transit_number, presence: true,
                                      length:   { maximum: 5 },
                                      format:   { with: /\A[0-9]+\z/, message: "must be numeric" }

    validates :account_number, presence: true,
                               length:   { maximum: 12 },
                               format:   { with: /\A[0-9]+\z/, message: "must be numeric" }

    validates :bank_account_type_code, inclusion: %w[0 1 2]

    validates :currency_code, presence: true,
                              length:   { maximum: 3 },  # Inclusion rule makes this superfluous for now, but needed in future.
                              inclusion: %w[USD CAD]


    def add
      response = request :add_bank_account, :addBankAccountRequest
      response
    end

    def remove
      self.id  = self.bank_account_id
      response = delete_request
      response
    end

    # def update
    #   request :modify_bank_account, :modifyBankAccountRequest
    # end

  end
end
