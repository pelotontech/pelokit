require 'spec_helper'
require "savon/mock/spec_helper"
require 'hashie'

describe Pelokit::Request do

  include Savon::SpecHelper
  before(:all) { savon.mock!   }
  after(:all)  { savon.unmock! }

    let :hashie_class do
      Class.new(Hashie::Dash) do
        property :foo_bar
        property :bar_baz

        include Pelokit::Request

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
end
