require "semantria/version"
require "semantria/auth"
require 'httparty'

module Semantria
  class Client
    include HTTParty
    base_uri 'https://api35.semantria.com'

    HEADERS = {
      'Content-type' => "application/x-www-form-urlencoded",
      'x-api-version' => 3,
      'x-app-name' => 'semantria_Gem',
      'Accept-Encoding' => 'gzip'
    }

    attr_reader :consumer_secret, :consumer_key, :auth

    def initialize(consumer_key, consumer_secret)
      @auth = Authenticator.new(consumer_key, consumer_secret)
      @consumer_secret, @consumer_key = consumer_secret, consumer_key
    end

    def headers
      @headers ||= HEADERS.merge({'Authorization' => auth.header})
    end

  end
end
