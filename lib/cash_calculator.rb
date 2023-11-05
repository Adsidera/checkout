# frozen_string_literal: true

class CashCalculator
  Product = Struct.new(:product_code, :name, :price, :discount)

  PRODUCTS = {
    'GR1' => Product.new('GR1','green tea', 311),
    'SR1' => Product.new('SR1','strawberries', 500),
    'CF1' => Product.new('CF1','coffee', 1123),
  }
  def initialize(order)
    @order = order
    @quantities = order.group_by(&:itself).transform_values(&:count) # e.g.: {'SR1' => 2}
  end

  def total

  end
end