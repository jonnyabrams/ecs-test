require 'csv_parser'

describe CsvParser do
  
  let(:file_path) { './fixtures/test_file.csv' }
  subject(:parser) { described_class.new(file_path) }

  describe '#initialize' do
    it 'initializes with a file_path' do
      expect(parser.file_path).to eq file_path
    end
  end

  describe '#parse' do
    it 'parses a csv file' do
      expect(parser.parse).to eq "Hello World"
    end
  end
end
