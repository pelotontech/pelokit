require 'active_model'
require 'spec_helper'
require 'savon/mock/spec_helper'

describe Pelokit::Transport::Soap do

  include Savon::SpecHelper
  before(:all) { savon.mock!   }
  after(:all)  { savon.unmock! }

    let :hashie_class do
      Class.new(Pelokit::RequestBase) do
        property :foo_bar
        property :bar_baz

        include Pelokit::Transport::Soap
        include ActiveModel::Validations

        def self.model_name
          ActiveModel::Name.new(self, nil, "temp")
        end

        validates :foo_bar, presence: true

        def invoke
          request :add_bank_account, :addBankAccountRequest
        end
      end
    end

    let(:message) do
      { "FooBar"=>"1",
        "BarBaz"=>"2",
        "ClientId"=>"foo",
        "AccountName"=>"baz",
        "Password"=>"bar",
        "ApplicationName"=>"pelokit #{Pelokit::VERSION}" }
    end
    let (:success_xml) { IO.read 'spec/data/add_bank_account_success.xml' }


    before :each do
      Pelokit.configure do |c|
        c.client_id    = 'foo'
        c.password     = 'bar'
        c.account_name = 'baz'
      end
      @obj = hashie_class.new foo_bar: 1, bar_baz: 2
    end

    it 'should build the hash in camelized form' do
      expect(@obj.send(:options)).to match(message)
    end

    it 'should parse the response XML' do
      savon.expects(:add_bank_account).with(message: { addBankAccountRequest: message }).returns(success_xml)
      response = @obj.invoke
      expect(@obj.success).to eq(true)
      expect(@obj.message).to eq('Success')
      expect(response).to match("success"=>true,
                                "message"=>"Success",
                                "message_code"=>"0",
                                "bank_account_id"=>"23234qw")
    end

    it 'should raise on request if the object is not valid' do
      expect(@obj.valid?).to eq(true)
      @obj.foo_bar = nil
      expect(@obj.valid?).to eq(false)
      expect { @obj.invoke }.to raise_error(Pelokit::Transport::Soap::Error)
    end
end
