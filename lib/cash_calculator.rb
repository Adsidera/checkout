# frozen_string_literal: true

# A class for calculating total checkout of a shopping cart
class CashCalculator
  Product = Struct.new(:product_code, :name, :price)

  PRODUCTS = {
    'GR1' => Product.new('GR1','green tea', 311),
    'SR1' => Product.new('SR1','strawberries', 500),
    'CF1' => Product.new('CF1','coffee', 1123),
  }.freeze

  DISCOUNTS = {
    'GR1' => { minimum_quantity: 2, discount: 0.5 },
    'SR1' => { minimum_quantity: 3, discount: 0.1 },
    'CF1' => { minimum_quantity: 3, discount: 0.3333 },
  }.freeze

  def initialize(order)
    order = order.delete_if { |item| PRODUCTS[item].nil? }
    @order_items = order.uniq
    @quantities = order.group_by(&:itself).transform_values(&:count) # e.g.: {'SR1' => 2, 'GR1' => 1}
    @subtotal = []
  end

  def total
    @order.uniq.each do |item|
      @subtotal << subtotal_per(item)
    end
    (@subtotal.sum.to_f / 100).round(2)
  end

  def printout
    puts '| PRODUCT   | € X QUANTITY | DISCOUNT | SUBTOTAL'
    @order.uniq.each do |item|
      puts "| #{PRODUCTS[item].name} | #{PRODUCTS[item].price.to_f / 100}€ X #{@quantities[item]} | #{(DISCOUNTS[item][:discount] * 100).to_i}% on > #{DISCOUNTS[item][:minimum_quantity]} | #{(subtotal_per(item).to_f/ 100).round(2)}€"
    end
  end

  private

  def subtotal_per(item)
    if @quantities[item] >= DISCOUNTS[item][:minimum_quantity]
      price_per(item) * @quantities[item]
    else
      PRODUCTS[item].price * @quantities[item]
    end
  end

  def price_per(item)
    PRODUCTS[item].price - PRODUCTS[item].price * DISCOUNTS[item][:discount]
  end
end
