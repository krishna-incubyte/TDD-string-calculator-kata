class StringCalculator
  DEFAULT_DELIMITER = ','

  def initialize(string)
    @string = string
  end

  def execute
    multiline_strings = @string.split("/n")
    multiline_strings.map do |string|
      string.split(DEFAULT_DELIMITER).map(&:to_i)
    end.flatten.sum
  end
end