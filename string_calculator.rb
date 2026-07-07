require './errors'

class StringCalculator
  DEFAULT_DELIMITER = ','
  NEWLINE_IDENTIFIER = '/n'
  PARSER_REGEX = %r{\A//(.+?)\n(.*)}m

  def initialize(string)
    @string = string
  end

  def execute
    delimiter, parsed_string = parse_string

    multiline_strings = parsed_string.split(NEWLINE_IDENTIFIER)
    multiline_strings.sum do |string|
      integer_array = string.split(delimiter).map(&:to_i)
      raise Errors::InvalidNumber if integer_array.find(&:negative?)
      integer_array.sum
    end
  end

  private

  def parse_string
    match = @string.match(PARSER_REGEX)
    delimiter, parsed_string = if match
      [match[1], match[2]]
    else
      [DEFAULT_DELIMITER, @string]
    end
  end
end