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
        'ClientId'                  => '58',
        'AccountName'               => 'Factorial Systems',
        'Password'                  => 'Password123',
        'ApplicationName'           => 'soapui',
        'BankAccountId'             =>  nil,
        'BankAccountName'           =>  'atb3 account whatever',
        'BankAccountOwner'          =>  'rowing canada',
        'BankAccountTypeCode'       =>  1,
        'FinancialInsitutionNumber' => 000,
        'BranchTransitNumber'       => 00000,
        'AccountNumber'             => 00000000,
        'CurrencyCode'              => 'cad',
        'VerifyAccountByDeposit'    => 0,
        'LanguageCode'              => 'en',
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
