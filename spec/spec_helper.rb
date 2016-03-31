require 'bundler/setup'
Bundler.setup

require 'scraper'
require 'vcr'
require 'webmock/rspec'

RSpec.configure do |config|
end

VCR.configure do |config|
  config.cassette_library_dir = "spec/fixtures/vcr_cassettes"
  config.hook_into :webmock
end
