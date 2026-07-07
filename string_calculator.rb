class StringCalculator
  DEFAULT_DELIMITER = ','
  NEWLINE_IDENTIFIER = '/n'

  def initialize(string)
    @string = string
  end

  def execute
    match = @string.match(%r{\A//(.+?)\n(.*)}m)
    delimiter, parsed_string = if match
      [match[1], match[2]]
    else
      [DEFAULT_DELIMITER, @string]
    end

    multiline_strings = parsed_string.split(NEWLINE_IDENTIFIER)
    multiline_strings.sum do |string|
      string.split(delimiter).sum(&:to_i)
    end
  end
end