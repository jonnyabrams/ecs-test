require 'csv_parser'
require 'csv'

describe CsvParser do
  
  let(:file_path) { 'spec/fixtures/test_file.csv' }
  subject(:parser) { described_class.new(file_path) }

  describe '#initialize' do
    it 'initializes with a file_path' do
      expect(parser.file_path).to eq file_path
    end
  end

  describe '#parse' do
    it 'parses a csv file' do
      expect(parser.parse["CompanyName"]).to eq "Test Name 1"
    end
  end
end
