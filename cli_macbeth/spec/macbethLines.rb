require 'rspec/autorun'
require 'nokogiri'
require 'vcr'
require 'webmock/rspec'
require_relative '../lib/macbethLines'
require 'byebug'
# require 'active_support/core_ext/kernel/reporting'
require_relative '../spec/support/vcr_setup'
WebMock.disable_net_connect!(allow_localhost: true)


url = "http://www.ibiblio.org/xml/examples/shakespeare/macbeth.xml"

describe "MacbethParser" do
  let (:response) {MacbethLines.new(url)}
    describe '#initialize' do
      it 'is an instance of MacbethParser' do
        VCR.use_cassette 'model/xml_data' do
          expect(response).to be_an_instance_of(MacbethLines)
        end
      end
      it 'parses the XML data into Nokogiri' do
        VCR.use_cassette 'model/xml_data' do
          @data = response.speech_data
        end
        expect(@data).to be_a(Nokogiri::XML::NodeSet)

      end

    describe '#line_count' do
      before do
        VCR.use_cassette 'model/xml_data' do
          response.line_count
          @store = response.char_hash
        end
      end
      it 'calculates the correct line count' do
        expect(@store['Macbeth']).to eq(719)
      end

      it 'does not include "All"' do
        expect(@store.keys.include?('All')).to eq(false)
      end
      it 'has the correct number of speakers' do
        @num_speakers = @store.keys.length
        expect(@num_speakers).to eq(40)
      end

    end


  end
end
