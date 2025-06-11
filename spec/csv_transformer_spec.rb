require 'csv'
require 'csv_transformer'

describe CsvTransformer do
  let(:file_path) { './spec/fixtures/test-companies.csv' }
  subject(:transformer) { described_class.new(file_path) }

  describe '#initialize' do
    it 'initializes with a file_path' do
      expect(transformer.file_path).to eq file_path
    end
  end

  describe '#transform' do
    it 'transforms a csv file into the desired columns' do

      first_row = {
        "company_name" => "ACTIVE COMPANY LTD",
        "company_number" => "11111111",
        "address" => "123 Main St, London, SW1A 1AA",
        "previous_name" => "N/A"
      }

      second_row = {
        "company_name" => "DORMANT COMPANY LTD",
        "company_number" => "22222222",
        "address" => "456 High St, Manchester, M1 1AA",
        "previous_name" => "N/A"
      }

      expect(transformer.transform[0].to_h).to eq first_row
      expect(transformer.transform[1].to_h).to eq second_row
      expect(transformer.transform.length).to eq 3
    end
  end

  describe 'filter for only active companies' do

    it 'filters for only active companies' do
      all_results = transformer.transform
      active_results = transformer.transform(filter_for_active_companies: true)

      expect(all_results.length).to eq 3
      expect(active_results.length).to eq 2
      
      active_company_names = active_results.map { |row| row["company_name"] }
      expect(active_company_names).to include("ACTIVE COMPANY LTD", "ANOTHER ACTIVE LTD")
      expect(active_company_names).not_to include("DORMANT COMPANY LTD")
    end
  end
end
