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

      it 'Returns correct response code on status check' do
        expect(described_class.new(ENV['SEMANTRIA_KEY'],ENV['SEMANTRIA_SECRET']).check_status.code).to eq 200
      end
    end
    context 'queueing documents' do
      before do
        VCR.insert_cassette 'queueing', :record => :new_episodes
      end

      after do
        VCR.eject_cassette
      end

      it 'successfully queues one document' do
        client = described_class.new(ENV['SEMANTRIA_KEY'],ENV['SEMANTRIA_SECRET'])
        request = client.queue_document('Very nice restaurant')
        expect(request.request.http_method).to eq Net::HTTP::Post
        expect(request.response.code).to eq "202"
      end

      it 'successfully queues batch of documents' do
        client = described_class.new(ENV['SEMANTRIA_KEY'],ENV['SEMANTRIA_SECRET'])
        request = client.queue_batch(['Very nice restaurant', 'What shithole'])
        expect(request.request.http_method).to eq Net::HTTP::Post
        expect(request.response.code).to eq "202"
      end
    end
    context 'retrieving document' do
      before do
        VCR.insert_cassette 'retrieving', :record => :new_episodes
      end

      after do
        VCR.eject_cassette
      end
      it 'successfully retrieves analysis for all queued documents' do
        client = described_class.new(ENV['SEMANTRIA_KEY'],ENV['SEMANTRIA_SECRET'])
        request = client.queue_document('Very nice restaurant')
        sleep(10)
        expect(client.get_processed_documents.first["phrases"]).to_not be_empty
      end

      it 'successfully retrieves a single document based on id' do
        client = described_class.new(ENV['SEMANTRIA_KEY'],ENV['SEMANTRIA_SECRET'])
        id = rand(10 ** 10).to_s
        request = client.queue_document(id, 'Very nice restaurant')
        sleep(10)
        expect(client.get_document["phrases"]).to_not be_empty
      end
    end
  end
end
