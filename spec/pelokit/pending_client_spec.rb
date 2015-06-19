require 'spec_helper'

describe Pelokit::PendingClient do

  let(:token) { 'ABCDEF' }

  it 'should build an OpenStruct from the response' do
    obj           = described_class.new token
    obj.client_id = 'foo'
    obj.password  = 'bar'
    HTTParty.expects(:get).with("#{Pelokit.rest}/pendingclients/ABCDEF", basic_auth: {username: 'foo', password: 'bar'})
                           .returns stub(code: 200, parsed_response: { a: '1' })
    expect(obj.get).to eq(OpenStruct.new a: '1')
  end

  it 'should use the Pelokit creds if set' do
    Pelokit.configure do |p|
      p.client_id = 'floob'
      p.password  = 'blarry'
    end

    obj           = described_class.new token
    HTTParty.expects(:get).with("#{Pelokit.rest}/pendingclients/ABCDEF", basic_auth: {username: 'floob', password: 'blarry'})
                           .returns stub(code: 200, parsed_response: { a: '1' })
    expect(obj.get).to eq(OpenStruct.new a: '1')
  end

  it 'should raise on not a 200 OK response' do
    obj = described_class.new token
    HTTParty.expects(:get).returns stub(code: 401, message: 'Unauthorized')
    expect {
      obj.get
    }.to raise_error(Pelokit::PendingClient::RestError, '401 Unauthorized')
  end

end
