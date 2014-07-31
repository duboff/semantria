require 'coveralls'
Coveralls.wear!

require 'pry'
require 'semantria'
require 'webmock/rspec'
require 'vcr'

#VCR config
VCR.config do |c|
  c.cassette_library_dir = 'spec/fixtures/dish_cassettes'
  c.stub_with :webmock
end
