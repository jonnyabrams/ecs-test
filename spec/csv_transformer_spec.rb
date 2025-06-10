require 'csv_transformer'
require 'csv'

describe CsvTransformer do
  # usually I would create a test fixture, but for the purposes of this tech test I'm just using the CSV provided
  let(:file_path) { './companies-input.csv' }
  subject(:transformer) { described_class.new(file_path) }

  describe '#initialize' do
    it 'initializes with a file_path' do
      expect(transformer.file_path).to eq file_path
    end
  end

  describe '#transform' do
    it 'transforms a csv file into the desired columns' do

      first_row = {
        "company_name" => "FOUNDRY HEALTHCARE LTD",
        "company_number" => "11350745",
        "address" => "SCHOOL HILL HOUSE, LEWES, BN7 2LU",
        "previous_name" => "N/A"
      }

      second_row = {
        "company_name" => "FOUNDRY HILL LTD",
        "company_number" => "08266458",
        "address" => "LANG BENNETTS THE OLD CARRIAGE WORKS, TRURO, TR1 1DG",
        "previous_name" => "N/A"
      }

      expect(transformer.transform[0].to_h).to eq first_row
      expect(transformer.transform[1].to_h).to eq second_row
      expect(transformer.transform.length).to eq 24
    end
  end
end
