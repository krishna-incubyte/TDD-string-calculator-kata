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
      string.split(delimiter).sum(&:to_i)
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