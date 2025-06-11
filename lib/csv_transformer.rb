class CsvTransformer
  attr_reader :file_path

  def initialize(file_path)
    @file_path = file_path
  end

  def transform(filters: [])
    csv_text = File.read(@file_path)

    csv = CSV.parse(csv_text, :headers => true, header_converters: lambda { |h| h.strip })

    if filters.any?
      csv = csv.select { |row| row_matches_all_filters?(row, filters) }
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

  def row_matches_all_filters?(row, filters)
    filters.all? do |filter|
      attribute = filter[:attribute]
      comparator = filter[:comparator]
      value = filter[:value].downcase

      cell_value = row[attribute].downcase

      next false if cell_value.nil?

      compare(cell_value.strip, comparator, value)
    end
  end

  def compare(a, comparator, b)
    # TODO: handle different types - this implementation is set up only for strings
    case comparator
    when "===", "=="
      a == b
    when "!==", "!="
      a != b
    when ">"
      a > b
    when "<"
      a < b
    else
      raise ArgumentError, "Unsupported comparator: #{comparator}"
    end
  end
end