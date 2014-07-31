require 'coveralls'
Coveralls.wear!

require 'pry'
require 'semantria'
require 'webmock/rspec'
require 'vcr'

#VCR config
VCR.configure do |c|
  c.cassette_library_dir = 'spec/fixtures/dish_cassettes'
  c.hook_into :webmock
end
