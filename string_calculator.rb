require './errors'

class StringCalculator
  DEFAULT_DELIMITER = ','
  NEWLINE_IDENTIFIER = '/n'
  PARSER_REGEX = %r{\A//(.+?)\n(.*)}m
  MAX_PERMITTED_INTEGER = 1000
  MULTI_DELIMITER_REGEX = /\[([^\[\]]+)\]/

  def initialize(string)
    @string = string
  end

  def execute
    parsed_string = parse_string

    multiline_strings = parsed_string.split(NEWLINE_IDENTIFIER)

    multiline_strings.sum do |string|
      integer_array = string.split(DEFAULT_DELIMITER).map(&:to_i)
      negative_numbers = integer_array.select(&:negative?)
      raise Errors::InvalidNumber.new("Invalid negative numbers: #{negative_numbers.join(', ')}") if integer_array.find(&:negative?)
      integer_array.reject { |number| number >= MAX_PERMITTED_INTEGER }.sum
    end
  end

  private

  def parse_string
    match = @string.match(PARSER_REGEX)
    return @string unless match

    delimiters_string = match[1]
    delimeters = delimiters_string.scan(MULTI_DELIMITER_REGEX).flatten

    delimeters = [delimiters_string] if delimeters.empty?

    string = match[2]
    delimeters.each { |delimiter| string.gsub!(delimiter, DEFAULT_DELIMITER) }

    string
  end
end