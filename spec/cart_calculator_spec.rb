require 'total_amount_promotion'
require 'product_quantity_promotion'
require 'cart_calculator'

describe CartCalculator do

  subject { CartCalculator.new(cart.each, promotions) }

  let(:cart) do
    [ mock(product: p1, quantity: 2),
      mock(product: p2, quantity: 1),
      mock(product: p3, quantity: 1)
    ]
  end

  let(:p1) { mock price: 9.25 }
  let(:p2) { mock price: 45.00 }
  let(:p3) { mock price: 19.95 }

  let(:promotions)        { [over_60_promotion, two_p1_promotion] }
  let(:over_60_promotion) { TotalAmountPromotion.new(60, 0.1) }
  let(:two_p1_promotion)  { ProductQuantityPromotion.new(p1, 2, nil, 8.5) }
  let(:one_p2_promotion)  { ProductQuantityPromotion.new(p2, 1, 0.2) }

  context 'when no promotions' do
    let(:promotions) {[]}
    its(:total_amount) { should eq(83.45) }
    its(:item_amounts) { should include(18.5, 45, 19.95) }
  end

  context 'when there are item based promotions' do
    let(:promotions)   { [one_p2_promotion, two_p1_promotion] }
    its(:total_amount) { should eq(72.95) }
    its(:item_amounts) { should include(17, 36, 19.95) }    
  end

  context 'when there are cart total based promotions' do
    let(:promotions)   { [over_60_promotion] }
    its(:total_amount) { should eq(75.11) }
    its(:item_amounts) { should include(18.5, 45, 19.95) }    
  end

  context 'when there are item and cart total based promotions' do
    let(:promotions)   { [over_60_promotion, two_p1_promotion] }
    its(:total_amount) { should eq(73.76) }
    its(:item_amounts) { should include(17, 45, 19.95) }
  end

end