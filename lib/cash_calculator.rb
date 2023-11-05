# frozen_string_literal: true

require 'pry'
class CashCalculator
  Product = Struct.new(:product_code, :name, :price)

  PRODUCTS = {
    'GR1' => Product.new('GR1','green tea', 311),
    'SR1' => Product.new('SR1','strawberries', 500),
    'CF1' => Product.new('CF1','coffee', 1123),
  }

  DISCOUNTS = {
    'GR1' => { minimum_quantity: 2, discounted_quantity: 1},
    'SR1' => { minimum_quantity: 3, discounted_price: 450},
    'CF1' => { minimum_quantity: 3, discounted_price: 748.67}
  }

  def initialize(order)
    @order = order
    @quantities = order.group_by(&:itself).transform_values(&:count) # e.g.: {'SR1' => 2}
  end

  def total
    subtotal = []
    @order.uniq.each do |item|
      if @quantities[item] >= DISCOUNTS[item][:minimum_quantity]
        subtotal << price_per(item) * quantity_per(item)
      else
        subtotal << PRODUCTS[item].price * @quantities[item]
      end
    end
    (subtotal.sum.to_f / 100).round(2)
  end

  def price_per(item)
    DISCOUNTS[item][:discounted_price] || PRODUCTS[item].price
  end

  def quantity_per(item)
    @quantities[item] - DISCOUNTS[item][:discounted_quantity].to_i
  end
end