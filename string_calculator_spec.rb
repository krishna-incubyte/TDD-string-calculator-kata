require './string_calculator'

RSpec.describe StringCalculator do
  describe '#execute' do
    it 'adds the numbers in string - case 1' do
      service = described_class.new("1,2")

      result = service.execute

      expect(result).to eq(3)
    end

    it 'adds the numbers in given string - case 2' do
      service = described_class.new(",1,2,3,")

      result = service.execute

      expect(result).to eq(6)
    end

    it 'returns 0 for an empty string' do
      service = described_class.new("")

      result = service.execute

      expect(result).to eq(0)
    end

    context 'when there is a newline' do
      it 'adds the numbers - case 1' do
        service = described_class.new("1/n2,2")

        result = service.execute

        expect(result).to eq(5)
      end

      it 'adds the numbers - case 2' do
        service = described_class.new("1/n2,2,3,/n")

        result = service.execute

        expect(result).to eq(8)
      end
    end

    context 'when there are custom delimiters' do
      it 'add the numbers - case 1' do
        service = described_class.new("//;\n1;2")

        result = service.execute

        expect(result).to eq(3)
      end

      it 'add the numbers - case 2' do
        service = described_class.new("//:;\n1:;2")

        result = service.execute

        expect(result).to eq(3)
      end
    end
  end
end