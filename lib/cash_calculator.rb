# frozen_string_literal: true

class CashCalculator
  Product = Struct.new(:product_code, :name, :price, :discount)

  PRODUCTS = {
    'GR1' => Product.new('GR1','green tea', 311),
    'SR1' => Product.new('SR1','strawberries', 500),
    'CF1' => Product.new('CF1','coffee', 1123),
  }
  def initialize(products)
    @products = products
  end

  def total
  end
end