# A CLI Checkout

## Getting started
Just `bundle install`.

## How to use it
Open a terminal in the root directory of the project and run the Ruby script `checkout.rb` with any combination of
the registered product codes (`GR1`, `SR1`, and `CF1`), without commas.

```ruby
ruby checkout.rb GR1 GR1
```

This will call the `CashCalculator` and calculate the total amount to pay for the related products.

# Cash Calculator
I have decided to use a simple Ruby class, not linked to any Rails modules or databases.
It takes an array of product codes and initializes an `@order_items`, `@quantities` and an empty `@subtotal` instance variables.
The total amount to pay is calculated by `CashCalculator#total`.
The subtotal for each order item is printed by `CashCalculator#printout`.

## Find the registered product from a product code
Products are registered via a convenient `Product` struct,
which holds information also on the related discounts and the minimum discountable quantity.
Mapping product codes to the corresponding `Product` struct instance makes for a fast lookup of registered products.

## In a real-world scenario
Structs are convenient, but they are not persistent outside the lifespan of an instance.
In a real-world scenario, I would expect to have at least  `Product`, `Order`, and `OrderItem` and `Discount` objects mapped to related database tables with suitable associations.
This lib class could be responsible for calculating the total amount to pay for a new `Order` and its associated `OrderItems` objects, including their related discounts, if applicable.
In that case, this lib class could be easily adjusted to deal with such objects.

## More documentation
You can also display this README and more documentation on this class with `yard` by running `yard doc`, if you have it installed.