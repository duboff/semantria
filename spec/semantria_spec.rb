require 'spec_helper'

describe Semantria::Client do
  context 'default attributes' do
    it 'include httparty methods' do
      expect(described_class).to include HTTParty
    end
    it "must have the base url set to the Semantria API endpoint" do
      expect(described_class.base_uri).to eq 'https://api35.semantria.com'
    end
  end
end
