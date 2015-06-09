require 'spec_helper'

describe Pelokit::ElectronicFundsTransfer do

  it 'should ensure validity' do
    obj = described_class.new
    expect(obj.valid?).to eq(false)
    obj.bank_account_id = '123'
    obj.amount          = '12.12'
    obj.transfer_date   = '2015-10-10'
    expect(obj.valid?).to eq(true)
  end

  it 'should check validity of amounts' do
    obj = described_class.new
    obj.bank_account_id = '123'
    obj.amount          = '12.12'
    obj.transfer_date   = '2015-10-10'
    expect(obj.valid?).to eq(true)
    [nil, '12.111', 'abc', '', '121a'].each do |v|
      obj.amount = v
      expect(obj.valid?).to eq(false)
    end
  end

end
