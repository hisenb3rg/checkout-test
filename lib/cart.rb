require 'forwardable'

# Public: Model class for representing cart content.
# Provides functionality to list all products along with quantities
# no matter the input order. It is totaly decoupled and unaware of
# product representation, pricing, promotions. 
#
class Cart
  class CartItem < Struct.new(:product, :quantity); end

  extend Forwardable
  def_delegators :@cart, :[], :size, :each_key
  def_delegator  :@cart, :each_value, :each

  def initialize
    @cart = Hash.new
  end

  def add(product, quantity: 1)
    if @cart.include? product
      @cart[product].quantity += 1
    else
      @cart[product] = CartItem[product, quantity]
    end
  end
end