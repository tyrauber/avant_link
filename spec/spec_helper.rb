require 'avant_link'
require 'rubygems'
require 'bundler/setup'
require 'support/vcr'
require 'support/matchers'

RSpec.configure do |config|
  
  config.after(:each) do
    AvantLink.reset
  end
end
