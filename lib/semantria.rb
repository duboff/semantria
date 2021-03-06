require "semantria/version"
require "semantria/auth"
require 'httparty'

module Semantria
  class Client
    include HTTParty
    # debug_output $stderr
    base_uri 'https://api35.semantria.com'
    format :json

    attr_reader :consumer_secret, :consumer_key, :auth

    def initialize(consumer_key, consumer_secret)
      @auth = Authenticator.new(consumer_key, consumer_secret)
      @consumer_secret, @consumer_key = consumer_secret, consumer_key
    end

    def check_status
      auth.uri = URI.parse(self.class.base_uri + "/status.json")
      self.class.get("/status.json", verify: false, headers: auth.headers, query: auth.parameters_hash)
    end

    def queue_document(text, id=rand(10 ** 10).to_s)
      doc = {'id' => id, 'text' => text}

      auth.uri = URI.parse(self.class.base_uri + "/document")
      json = JSON.generate doc
      self.class.post("/document", verify: false, headers: auth.headers, query: auth.parameters_hash, body: json)
    end

    def queue_batch(batch)
      auth.uri = URI.parse(self.class.base_uri + "/document/batch")
      batch = batch.map do |document|
        {'id' => rand(10 ** 10).to_s.rjust(10, '0'), 'text' => document}
      end
      json = JSON.generate batch
      self.class.post("/document/batch", verify: false, headers: auth.headers, query: auth.parameters_hash, body: json)
    end

    def get_processed_documents
      auth.uri = URI.parse(self.class.base_uri + "/document/processed.json")
      self.class.get("/document/processed.json", verify: false, headers: auth.headers, query: auth.parameters_hash, body: nil)
    end

    def get_document(id)
      auth.uri = URI.parse(self.class.base_uri + "/document/#{id}.json")
      self.class.get("/document/#{id}.json", verify: false, headers: auth.headers, query: auth.parameters_hash, body: nil)
    end
  end
end
