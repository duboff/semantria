require 'securerandom'
require 'openssl'
require 'cgi'
require 'base64'
require 'digest/md5'
require 'digest/sha1'
require 'uri'

module Semantria

  class Authenticator
    attr_reader :consumer_secret, :consumer_key
    attr_accessor :uri

    def initialize(consumer_key, consumer_secret)
      @consumer_secret, @consumer_key = consumer_secret, consumer_key
    end

    def headers
      {'Authorization' => parameters_hash.merge({'OAuth realm' => '', "oauth_signature" => signature}).map { |k, v| "#{k}=#{v}" }.join(',')}
    end

    def parameters_hash
      { "oauth_version" => '1.0',
        "oauth_timestamp" => timestamp,
        "oauth_nonce" => nonce,
        "oauth_signature_method" => "HMAC-SHA1",
        "oauth_consumer_key" => consumer_key }
    end

    def updated_uri
      uri.query = parameters_hash.map {|k, v| "#{k}=#{v}"}.join('&').gsub('+', '%20').gsub('%7E', '~')
      uri
    end

    def path
      updated_uri.request_uri
    end

    private

    def nonce
      @nonce ||= rand(10 ** 20).to_s.rjust(20, '0')
    end

    def timestamp
      Time.now.to_i.to_s
    end

    def signature
      escape(sha_1)
    end

    def sha_1
      a = OpenSSL::HMAC.digest(OpenSSL::Digest.new('sha1'), Digest::MD5.hexdigest(consumer_secret), escape(updated_uri.to_s))
      Base64.encode64(a).chomp.gsub(/\n/, '')
    end

    def escape(s)
      CGI::escape(s)
    end
  end
end
