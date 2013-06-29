# Public: Service class for calculating cart items' and total amount
# based on given promotion rules.
# It does depend on product representation to read the base price,
# and on promotions interface.
# It decouples cart representation from promotions completely.
#
class CartCalculator

  def initialize(cart, promotions)
    @cart_enum  = cart
    @promotions = promotions
    
    @cart_item_promotions  = Hash.new
    @cart_total_promotions = []
    find_cart_item_promotions
    find_cart_total_promotions
  end

  def total_amount
    # here we merge multiple promotions into aggregate discount
    # this could be extracted into service object in the future to provide
    # more detailed control over merging of overlapping promotions
    total_discount = merge_multiple_promotion_discounts(@cart_total_promotions)
    # round according to spec to 2 decimal places
    (total_amount_wo_promotions * (1 - total_discount)).round(2)
  end

  def item_amounts
    @cart_enum.map do |item|
      # here we merge multiple promotions into aggregate discount
      # this could be extracted into service object in the future to provide
      # more detailed control over merging of overlapping promotions
      promotions = @cart_item_promotions[item.product] || []
      item_discount = merge_multiple_promotion_discounts(promotions)     

      # if promotion defines new price instead of a discount, best price is chosen
      best_price = merge_multiple_promotion_prices(promotions, item.product.price)

      # final item price
      best_price * (1 - item_discount) * item.quantity
    end
  end


  private

  # Total amount of cart content with applied total promotions.
  def total_amount_wo_promotions
    item_amounts.reduce(:+)
  end

  def find_cart_item_promotions
    for item in @cart_enum
      for promotion in @promotions.select(&:item_based?)
        if promotion.applicable_to? item.product, item.quantity
          @cart_item_promotions[item.product] ||= []
          @cart_item_promotions[item.product] << promotion
        end
      end
    end
  end

  def find_cart_total_promotions
    for promotion in @promotions.select(&:total_based?)
      if promotion.applicable_to? total_amount_wo_promotions
        @cart_total_promotions << promotion
      end
    end
  end

  def merge_multiple_promotion_discounts(promotions)
    discounts = promotions.map(&:discount).reject(&:nil?)
    merged_discount = discounts.reduce(:+) || 0    
    # prevent discount being larger than 100%
    [merged_discount, 1].min
  end

  def merge_multiple_promotion_prices(promotions, base_price)
    item_prices = promotions.map(&:discounted_price).reject(&:nil?)
    item_prices ||= []
    item_prices.push(base_price).min
  end

end