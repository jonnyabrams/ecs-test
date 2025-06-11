class CsvTransformer
  attr_reader :file_path

  def initialize(file_path)
    @file_path = file_path
  end

  def transform(filter_for_active_companies: false)
    csv_text = File.read(@file_path)

    csv = CSV.parse(csv_text, :headers => true, header_converters: lambda { |h| h.strip })

    if filter_for_active_companies
      csv = csv.filter { |row| row["CompanyStatus"].downcase === "active" }
    end

    csv.map { |row| transform_row(row) }
  end

  private

  def transform_row(row)
    output = {
      "company_name" => safe_value(row["CompanyName"]),
      "company_number" => safe_value(row["CompanyNumber"]),
      "address" => safe_value(format_address(row)),
      "previous_name" => safe_value(row["PreviousName_1.CompanyName"])
    }

    CSV::Row.new(output.keys, output.values)
  end

  def format_address(row)
    address_parts = [
      row['RegAddress.AddressLine1'],
      row['RegAddress.PostTown'],
      row['RegAddress.PostCode']
    ].compact.join(", ")
  end

  def safe_value(value)
    value.nil? || value.strip.empty? ? "N/A" : value
  end
end