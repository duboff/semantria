require 'spec_helper'

describe Semantria::Client do
  context 'default attributes' do
    it 'include httparty methods' do
      expect(described_class).to include HTTParty
    end
    it "must have the base url set to the Semantria API endpoint" do
      expect(described_class.base_uri).to eq 'https://api35.semantria.com'
    end
    it 'initialized with key and secret' do
      expect(described_class.new('bla', 'bla')).to respond_to :consumer_key
      expect(described_class.new('bla', 'abla').consumer_key).to eq 'bla'
      expect(described_class.new('bla', 'bla')).to respond_to :consumer_secret
      expect(described_class.new('bla', 'abla').consumer_secret).to eq 'abla'
    end
    it 'has default headers' do
      expect(described_class.new('bla', 'bla').headers).to be_a Hash
      expect(described_class.new('bla', 'bla').headers).not_to be_empty
    end
  end
end
