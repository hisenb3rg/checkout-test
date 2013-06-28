require_relative 'promotion_rule'

# Public: Class represents promotions based on cart items.
# It defines conditions at which promotion is applied and the consequences. 
# Supports both: by discount or by reduced price defined promotion.
#
class ProductQuantityPromotion < Struct.new(:product, :quantity,
                                            :discount, :discounted_price)
  include PromotionRule
  
  def item_based?; true; end
  def total_based?; false; end

  def applicable_to?(product, quantity)
    product == self.product and quantity >= self.quantity
  end
end
