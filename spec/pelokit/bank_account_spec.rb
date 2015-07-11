require 'spec_helper'

describe Pelokit::BankAccount do

  before :each do
    Pelokit.configure do |c|
      c.client_id    = 'foo'
      c.password     = 'bar'
      c.account_name = 'baz'
    end
  end

  let(:items) do
    { bank_account_id:             'my id',
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
    obj = described_class.new items
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

  it 'should be valid' do
    obj = described_class.new items
    expect(obj.valid?).to eq(true)
  end

  it 'should be invalid with incorrectly specified account number' do
    obj = described_class.new items
    obj.account_number = 'abc'
    expect(obj.valid?).to eq(false)
    expect(obj.errors.messages).to match(account_number: ['must be numeric'])
  end

  it 'should adhere to bank_account_id validation rules' do
    obj = described_class.new items
    expect(obj.valid?).to eq(true)
    obj.bank_account_id = ''
    expect(obj.valid?).to eq(true)
    obj.bank_account_id = nil
    expect(obj.valid?).to eq(false)
    obj.bank_account_id = 'a' * 32
    expect(obj.valid?).to eq(true)
    obj.bank_account_id = 'a' * 33
    expect(obj.valid?).to eq(false)
  end

  it 'should be invalid with incorrect length transit_number' do
    obj = described_class.new items
    expect(obj.valid?).to eq(true)
    obj.branch_transit_number = '666666'
    expect(obj.valid?).to eq(false)
    expect(obj.errors.full_messages).to eq(['Branch transit number is too long (maximum is 5 characters)'])
  end

  it 'should build the options hash in camelized form' do
    obj     = described_class.new items
    expect(obj.send(:options)).to match({"BankAccountId"             => "my id",
                                         "BankAccountName"           => "foobar",
                                         "BankAccountOwner"          => "owner",
                                         "BankAccountTypeCode"       => "1",
                                         "FinancialInsitutionNumber" => "001",
                                         "BranchTransitNumber"       => "23232",
                                         "AccountNumber"             => "121212",
                                         "CurrencyCode"              => "CAD",
                                         "VerifyAccountByDeposit"    => "1",
                                         "ClientId"                  => "foo",
                                         "AccountName"               => "baz",
                                         "Password"                  => "bar",
                                         "ApplicationName"           => "pelokit #{Pelokit::VERSION}"})

  end
  it 'should use other credentials if specified on the object' do
    obj              = described_class.new items
    obj.client_id    = 'other id'
    obj.password     = 'other password'
    obj.account_name = 'other account name'
    expect(obj.send(:options)).to match({"BankAccountId"             => "my id",
                                         "BankAccountName"           => "foobar",
                                         "BankAccountOwner"          => "owner",
                                         "BankAccountTypeCode"       => "1",
                                         "FinancialInsitutionNumber" => "001",
                                         "BranchTransitNumber"       => "23232",
                                         "AccountNumber"             => "121212",
                                         "CurrencyCode"              => "CAD",
                                         "VerifyAccountByDeposit"    => "1",
                                         "ClientId"                  => "other id",
                                         "AccountName"               => "other account name",
                                         "Password"                  => "other password",
                                         "ApplicationName"           => "pelokit #{Pelokit::VERSION}"})

  end
end
