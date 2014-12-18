require 'savon'

module Pelokit
  class BankAccount
    def initialize
    end

    def xml
      IO.read '/Users/dliggat/git/peloton/pelokit/savon.xml'
    end

    def craig
      IO.read '/Users/dliggat/git/peloton/pelokit/craig.xml'
    end

    def add
      attrs = {
        client_id:                   '58',
        account_name:                'Factorial Systems',
        password:                    'Password123',
        application_name:            'soapui',
        bank_account_id:             'd',
        bank_account_name:           'atb3 account',
        bank_account_owner:          'rowing canada',
        bank_account_type_code:      1,
        financial_insitution_number: 000,
        branch_transit_number:       00000,
        account_number:              00000000,
        currency_code:               'cad',
        verify_account_by_deposit:   0,
        language_code:               'en',
      }
      begin
        response = client.call(:add_bank_account, message: { "addBankAccountRequest" => attrs })
        # response = client.call(:add_bank_account, xml: craig)
      rescue Savon::SOAPFault, Savon::HTTPError => error
        error
      end
    end

    def client
      @client ||= Savon.client do
        wsdl("http://test.peloton-technologies.com/EppBanking.asmx?WSDL")
        # namespaces("xmlns:pel" => "http://www.peloton-technologies.com")
      end
      # client.operations => [:add_bank_account, :modify_bank_account, :withdraw_funds, :deposit_funds]
    end

  end
end
