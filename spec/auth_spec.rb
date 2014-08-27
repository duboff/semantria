require 'spec_helper'

describe Semantria::Authenticator do

  context 'generating URL parameters' do

    let(:auth) {described_class.new('bla', 'bla')}

    it 'generates correct parameters_hash' do
      expect(auth.parameters_hash).to be_a Hash
      expect(auth.parameters_hash["oauth_version"]).to eq '1.0'
      expect(auth.parameters_hash["oauth_signature_method"]).to eq "HMAC-SHA1"
      expect(auth.parameters_hash["oauth_consumer_key"]).to eq "bla"
    end

    it 'generates correct header' do
      auth.uri = URI.parse("http://google.com")
      expect(auth.headers).to be_a Hash
      expect(auth.headers.size).to eq 1
      expect(auth.headers['Authorization']).to be_a String
    end
    it 'generates correct path' do
      allow(auth).to receive(:timestamp).and_return("1")
      allow(auth).to receive(:nonce).and_return("2")

      auth.uri = URI.parse("http://google.com")
      expect(auth.path).to eq "/?oauth_version=1.0&oauth_timestamp=1&oauth_nonce=2&oauth_signature_method=HMAC-SHA1&oauth_consumer_key=bla"
    end
  end
end
