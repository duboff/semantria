require "semantria/version"
require 'httparty'

module Semantria
  class Client
    include HTTParty
    base_uri 'https://api35.semantria.com'
  end
end
