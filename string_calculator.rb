class StringCalculator
  DEFAULT_DELIMITER = ','
  NEWLINE_IDENTIFIER = '/n'

  def initialize(string)
    @string = string
  end

  def execute
    multiline_strings = @string.split(NEWLINE_IDENTIFIER)
    multiline_strings.sum do |string|
      string.split(DEFAULT_DELIMITER).sum(&:to_i)
    end
  end
end