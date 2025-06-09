class CsvParser
  attr_reader :file_path

  def initialize(file_path)
    @file_path = file_path
  end

  def parse
    csv_text = File.read(@file_path)

    csv = CSV.parse(csv_text, :headers => true)

    csv.first.to_h
  end
end