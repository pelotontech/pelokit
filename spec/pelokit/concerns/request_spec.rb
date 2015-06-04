require 'spec_helper'
require 'hashie'

describe Pelokit::Request do


    let :hashie_class do
      Class.new(Hashie::Dash) do
        property :foo_bar
        property :bar_baz

        include Pelokit::Request

        def invoke
          request :invoked, :invokedObj
        end
      end
    end

    before :each do
      Pelokit.configure do |c|
        c.client_id    = 'foo'
        c.password     = 'bar'
        c.account_name = 'baz'
      end
      @obj = hashie_class.new foo_bar: 1, bar_baz: 2
    end

    it 'should build the hash in camelized form' do
      expect(@obj.send(:options)).to match({"FooBar"=>"1",
                                            "BarBaz"=>"2",
                                            "ClientId"=>"foo",
                                            "AccountName"=>"baz",
                                            "Password"=>"bar",
                                            "ApplicationName"=>"pelokit #{Pelokit::VERSION}"})
    end
end
