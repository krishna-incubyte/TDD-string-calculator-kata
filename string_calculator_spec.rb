require './string_calculator'

RSpec.describe StringCalculator do
  describe '#execute' do
    it 'adds the numbers in string' do
      service = described_class.new("1,2")

      result = service.execute

      expect(result).to eq(3)
    end
  end
end