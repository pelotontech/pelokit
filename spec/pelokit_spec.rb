require "spec_helper"

describe Pelokit do

  before :each do
    Pelokit.configure do |c|
      c.client_id    = 'foo'
      c.password     = 'bar'
      c.account_name = 'baz'
    end
  end

  it "should generate api args do" do
    expect(Pelokit.api_args.keys).to match_array([:client_id, :account_name, :password, :application_name])
    expect(Pelokit.api_args[:application_name]).to match(/pelokit 0/)
  end
end
