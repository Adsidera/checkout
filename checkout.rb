require_relative 'lib/cash_calculator.rb'
require 'colorize'

list = ARGV

if list.join("").match(",")
  puts "Please use only GR1 SR1 or CF1 without commas in between, thanks! 😄🙏"
else
  calculator = CashCalculator.new(list)
  puts 'Your invoice'.colorize(:red)
  calculator.printout
  puts "Your total price is ".colorize(:yellow) + "#{calculator.total}€".colorize(:cyan)
end
