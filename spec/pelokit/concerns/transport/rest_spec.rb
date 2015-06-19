require 'spec_helper'

describe Pelokit::Transport::Rest do

  let :resource_class do
    Class.new(Pelokit::RequestBase) do

      include Pelokit::Transport::Rest
      self.restful_resource = 'foos'

      def initialize(token)
        @id = token
      end

      def get
        get_request
      end

      def remove
        delete_request
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

  it 'should build an OpenStruct from the response in a GET' do
    @obj.client_id = 'foo'
    @obj.password  = 'bar'
    HTTParty.expects(:get).with("#{Pelokit.rest}/foos/token", basic_auth: {username: 'foo', password: 'bar'})
                          .returns stub(code: 200, parsed_response: { a: '1' })
    expect(@obj.get).to eq(OpenStruct.new a: '1')
  end

  it 'should build an OpenStruct from the response in a DELETE' do
    @obj.client_id = 'foo'
    @obj.password  = 'bar'
    HTTParty.expects(:delete).with("#{Pelokit.rest}/foos/token", basic_auth: {username: 'foo', password: 'bar'})
                             .returns stub(code: 200, parsed_response: { a: '1' })
    expect(@obj.remove).to eq(OpenStruct.new a: '1')
  end

end
