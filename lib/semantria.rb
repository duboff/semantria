require "semantria/version"

module Semantria
  class Client
    include HTTParty
    base_uri 'http://api.dribbble.com'
  end
end
