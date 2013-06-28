require_relative 'promotion_rule'

# Public: Class represents promotions based on cart total amount.
# It defines conditions at which promotion is applied and consequent discount. 
#
class TotalAmountPromotion < Struct.new(:amount, :discount)
  include PromotionRule

  def item_based?; false; end
  def total_based?; true; end

  def applicable_to?(total_amount)
    total_amount >= amount
  end
end
