# frozen_string_literal: true

# A class for calculating total checkout of a shopping cart via CLI.
class CashCalculator
  # Product struct used for registering products.
  #
  # @attr [String] product_code
  # @attr [String] name
  # @attr [Integer] price
  # @attr [Integer] minimum_quantity Minimum quantity for applying a discount.
  # @attr [Float] discount Discount as a percentage fraction.
  Product = Struct.new(:product_code, :name, :price, :minimum_quantity, :discount)

  # Mapping of product codes to registered products, as `Product` struct instances.
  PRODUCTS = {
    'GR1' => Product.new('GR1', 'green tea', 311, 2, 0.5),
    'SR1' => Product.new('SR1', 'strawberries', 500, 3, 0.1),
    'CF1' => Product.new('CF1', 'coffee', 1123, 3, 0.3333)
  }.freeze

  # Initializes the order as an array of product codes, quantities of its products
  # and an empty subtotal.
  # Unknown product codes are ignored.
  #
  # @param [Array<String>] order An array containing product codes of existing products.
  def initialize(order)
    order = order.delete_if { |item| PRODUCTS[item].nil? }
    @order_items = order.uniq
    @quantities = order.group_by(&:itself).transform_values(&:count) # e.g.: {'SR1' => 2, 'GR1' => 1}
    @subtotal = []
  end

  # Calculates total by summing up all subtotals
  # and converting into a readable decimal value.
  def total
    @order_items.each do |item|
      @subtotal << subtotal_per(item)
    end
    (@subtotal.sum.to_f / 100).round(2)
  end

  # Print a detailed invoice.
  def printout
    puts '| PRODUCT   | € X QUANTITY | DISCOUNT | SUBTOTAL'
    @order_items.each do |item|
      puts "| #{PRODUCTS[item].name} |" \
           "#{PRODUCTS[item].price.to_f / 100}€ X #{@quantities[item]} |" \
           "#{(PRODUCTS[item].discount * 100).to_i}% on > #{PRODUCTS[item].minimum_quantity} |" \
           "#{(subtotal_per(item).to_f / 100).round(2)}€"
    end
  end

  private

  # Apply discounts only if the minimum quantity is reached,
  # by conveniently looking up the `item` in the `DISCOUNTS`.
  #
  # @param <String> item
  def subtotal_per(item)
    if @quantities[item] >= PRODUCTS[item].minimum_quantity
      discounted_price_per(item) * @quantities[item]
    else
      PRODUCTS[item].price * @quantities[item]
    end
  end

  def discounted_price_per(item)
    PRODUCTS[item].price - PRODUCTS[item].price * PRODUCTS[item].discount
  end
end
