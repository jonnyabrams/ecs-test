class CsvParser
  attr_reader :file_path
  
  def initialize(file_path)
    @file_path = file_path
  end

  def parse
    "Hello World"
  end
end