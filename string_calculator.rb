require './errors'

class StringCalculator
  DEFAULT_DELIMITER = ','
  NEWLINE_IDENTIFIER = '/n'
  PARSER_REGEX = %r{\A//(.+?)\n(.*)}m
  MAX_PERMITTED_INTEGER = 1000
  MULTI_DELIMITER_REGEX = /\[([^\[\]]+)\]/

  def initialize(string)
    @original_string = string
    initialize_data_and_delimiters
  end

  def execute
    update_data_from_multi_delimiters_with_default

    multiline_strings = @data.split(NEWLINE_IDENTIFIER)

    multiline_strings.sum { |string| sum(string) }
  end

  private

  def initialize_data_and_delimiters
    match = @original_string.match(PARSER_REGEX)

    @delimiters, @data = if match
      [parse_delimiters(match[1]), match[2]]
    else
      [[DEFAULT_DELIMITER], @original_string]
    end
  end

  def parse_delimiters(delimiters_string)
    delimeters = delimiters_string.scan(MULTI_DELIMITER_REGEX).flatten

    delimeters.empty? ? [delimiters_string] : delimeters
  end

  def update_data_from_multi_delimiters_with_default
    @delimiters.each { |delimiter| @data.gsub!(delimiter, DEFAULT_DELIMITER) }
  end

  def sum(string)
    integer_array = string.split(DEFAULT_DELIMITER).map(&:to_i)

    negative_numbers = integer_array.select(&:negative?)
    raise Errors::InvalidNumber.new("Invalid negative numbers: #{negative_numbers.join(', ')}") if integer_array.find(&:negative?)

    integer_array.reject { |number| number >= MAX_PERMITTED_INTEGER }.sum
  end
end