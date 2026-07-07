class StringCalculator

  def initialize(string)
    @string = string
  end

  def execute
    @string.split(',').sum(&:to_i)
  end
end