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

    delimiters = parse_delimiters(match[1])
    replace_delimiters_with_default(match[2], delimiters)
  end

  def parse_delimiters(delimiters_string)
    delimeters = delimiters_string.scan(MULTI_DELIMITER_REGEX).flatten

    delimeters.empty? ? [delimiters_string] : delimeters
  end

  def replace_delimiters_with_default(string, delimiters)
    delimiters.each { |delimiter| string.gsub!(delimiter, DEFAULT_DELIMITER) }

    return string
  end
end