# frozen_string_literal: true

require 'cash_calculator'

RSpec.describe CashCalculator do
  subject(:calculator) { described_class.new(products) }

  describe '#total' do

    context 'with more than 1 green tea' do
      let(:products) { %w[GR1 GR1] }

      it 'calculates total price of order items' do
        expect(calculator.total).to eq 3.11
      end
    end

    # context 'with more than 3 strawberries' do

    # end

    # context 'with more than 3 coffees' do

    # end
  end
end