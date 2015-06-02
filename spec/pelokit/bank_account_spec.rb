require 'spec_helper'

describe Pelokit::BankAccount do

  before :each do
    Pelokit.configure do |c|
      c.client_id    = 'foo'
      c.password     = 'bar'
      c.account_name = 'baz'
    end

    @items = { bank_account_id:             'my id',
               bank_account_name:           'foobar',
               bank_account_owner:          'owner',
               bank_account_type_code:      '1',
               financial_insitution_number: '001',
               branch_transit_number:       '23232',
               account_number:              '121212',
               currency_code:               'CAD',
               verify_account_by_deposit:   '1' }
  end

  it 'should have the correct properties' do
    obj = described_class.new @items
    expect(obj.to_hash).to eq({ bank_account_id:             'my id',
                                bank_account_name:           'foobar',
                                bank_account_owner:          'owner',
                                bank_account_type_code:      '1',
                                financial_insitution_number: '001',
                                branch_transit_number:       '23232',
                                account_number:              '121212',
                                currency_code:               'CAD',
                                verify_account_by_deposit:   '1' })
    obj.branch_transit_number = '99999'
    expect(obj.to_hash).to eq({ bank_account_id:             'my id',
                                bank_account_name:           'foobar',
                                bank_account_owner:          'owner',
                                bank_account_type_code:      '1',
                                financial_insitution_number: '001',
                                branch_transit_number:       '99999',
                                account_number:              '121212',
                                currency_code:               'CAD',
                                verify_account_by_deposit:   '1' })
  end

  it 'should build the options hash in camelized form' do
    obj     = described_class.new @items
    expect(obj.send(:options)).to match({"BankAccountId"=>"my id",
                                         "BankAccountName"=>"foobar",
                                         "BankAccountOwner"=>"owner",
                                         "BankAccountTypeCode"=>"1",
                                         "FinancialInsitutionNumber"=>"001",
                                         "BranchTransitNumber"=>"23232",
                                         "AccountNumber"=>"121212",
                                         "CurrencyCode"=>"CAD",
                                         "VerifyAccountByDeposit"=>"1",
                                         "ClientId"=>"foo",
                                         "AccountName"=>"baz",
                                         "Password"=>"bar",
                                         "ApplicationName"=>"pelokit #{Pelokit::VERSION}"})

  end
end
