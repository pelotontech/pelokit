require 'spec_helper'

describe Pelokit::RestRequest do

  let :resource_class do
    Class.new do

      include Pelokit::RestRequest
      self.restful_resource = 'foos'

      def initialize(token)
        @id = token
      end

      def get
        get_request
      end
    end
  end

  before :each do
    Pelokit.configure do |c|
      c.client_id    = 'foo'
      c.password     = 'bar'
      c.account_name = 'baz'
    end
    @obj = resource_class.new 'token'
  end

  it 'should have a restful resource' do
    expect(@obj.restful_resource).to eq('foos')
    expect(@obj.class.restful_resource).to eq('foos')
  end

  it 'should build an OpenStruct from the response' do
    @obj.client_id = 'foo'
    @obj.password  = 'bar'
    @obj.class.expects(:get).with('/foos/token', basic_auth: {username: 'foo', password: 'bar'})
                            .returns stub(code: 200, parsed_response: { a: '1' })
    expect(@obj.get).to eq(OpenStruct.new a: '1')
  end

end
