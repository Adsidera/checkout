# frozen_string_literal: true

require 'cash_calculator'

RSpec.describe CashCalculator do
  subject(:calculator) { described_class.new(order) }

  describe '#total' do

    context 'with more than 1 green tea' do
      let(:order) { %w[GR1 GR1] }

      it 'calculates total price applying a buy-one-get-one-free discount' do
        expect(calculator.total).to eq 3.11
      end
    end

    context 'with more than 3 strawberries' do
      let(:order) do
        %w[SR1 SR1 GR1 SR1]
      end

      it 'applies 10% bulk discount to strawberries' do
        expect(calculator.total).to eq 16.61
      end
    end

    context 'with 3 or more coffees' do
      let(:order) do
        %w[GR1 CF1 SR1 CF1 CF1]
      end

      it 'applies 2/3 discount on coffee price' do
        expect(calculator.total).to eq 30.57
      end
    end
  end
end