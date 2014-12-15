require 'bundler/setup'
require 'rspec/its'

Bundler.setup

require 'pelokit' # and any other gems you need

RSpec.configure do |config|
  config.mock_framework = :mocha

  config.expect_with :rspec do |c|
    c.syntax = [:expect]
  end
end
