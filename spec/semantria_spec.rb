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

    it 'has an auth object on initialization' do
      expect(described_class.new('bla', 'bla')).to respond_to :auth
      expect(described_class.new('bla', 'bla').auth).to be_a Semantria::Authenticator
    end

    context 'authentication' do
      before do
        VCR.insert_cassette 'base', :record => :new_episodes
      end

      after do
        VCR.eject_cassette
      end

      it 'authenticates' do
        expect(described_class.new(ENV['SEMANTRIA_KEY'],ENV['SEMANTRIA_SECRET']).check_status.code).to eq 200

      end


    end

  end
end
