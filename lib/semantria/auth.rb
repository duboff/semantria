require 'securerandom'
require 'openssl'
require 'cgi'
require 'base64'
require 'digest/md5'
require 'digest/sha1'

module Semantria

  class Authenticator
    attr_reader :nonce, :timestamp, :consumer_secret, :consumer_key

    def initialize(consumer_key, consumer_secret)
      @consumer_secret, @consumer_key = consumer_secret, consumer_key
      @nonce ||= get_nonce
      @timestamp ||= get_timestamp
    end

    def url_parameters
      @url_parameters ||= "OAuthVersionKey=1.0&OAuthTimestampKey=#{timestamp}&OAuthNonceKey=#{nonce}&OAuthSignatureMethodKey=HMAC-SHA1&OAuthConsumerKeyKey=#{consumer_key}"
      .gsub('+', '%20').gsub('%7E', '~')
    end

    def header
      @header ||= 'OAuth realm=' + url_parameters + "&OAuthSignatureKey=#{signature}"
    end

    private

    def get_nonce
      SecureRandom.hex(10)
    end

    def get_timestamp
      Time.now.to_i.to_s
    end

    def signature
      escape(sha_1)
    end

    def sha_1
      a = OpenSSL::HMAC.digest(OpenSSL::Digest.new('sha1'), Digest::MD5.hexdigest(consumer_secret), escape(url_parameters))
      Base64.encode64(a).chomp
    end

    def escape(s)
      CGI::escape(s)
    end
  end
end
