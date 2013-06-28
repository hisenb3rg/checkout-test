require_relative 'total_amount_promotion'
require_relative 'product_quantity_promotion'
require_relative 'cart'
require_relative 'cart_calculator'

# Public: Service class to offer checkout functionalities.
# It is here to provide the requested checkout API.
# Other than that it is just a proxy to other classes.
#
class Checkout
  extend Forwardable

  def_delegator :@cart, :add, :scan

  def initialize(promotions)
    @cart       = Cart.new
    @promotions = promotions
  end

  def total
    calc = CartCalculator.new(@cart.each, @promotions)
    calc.total_amount
  end

end
