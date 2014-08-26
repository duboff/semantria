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
      expecr(auth.headers['Authorization']).to be_a String
    end
  end
end
