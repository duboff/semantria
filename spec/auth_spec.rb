require 'spec_helper'

describe Semantria::Authenticator do

  context 'generating URL parameters' do

    let(:auth) {described_class.new('bla', 'bla')}

    it 'nonce is correct type' do
      expect(auth.nonce).to be_a String
      expect(auth.nonce.size).to eq 20
    end

    it 'has correct timestamp' do
      expect(auth.timestamp).to be_a String
    end

    it 'generates correct paramter string' do
      expect(auth.url_parameters).to eq "OAuthVersionKey=1.0&OAuthTimestampKey=#{auth.timestamp}&OAuthNonceKey=#{auth.nonce}&OAuthSignatureMethodKey=HMAC-SHA1&OAuthConsumerKeyKey=bla"
    end

    it 'generates correct header' do
      expect(auth).to receive(:signature).and_return('bla')
      expect(auth.header).to eq 'OAuth realm=' + auth.url_parameters + "&OAuthSignatureKey=bla"
    end
  end
end
