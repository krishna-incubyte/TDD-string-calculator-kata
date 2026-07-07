class StringCalculator
  DEFAULT_DELIMITER = ','

  def initialize(string)
    @string = string
  end

  def execute
    @string.split(DEFAULT_DELIMITER).sum(&:to_i)
  end
end