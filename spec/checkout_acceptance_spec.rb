require 'checkout'
require 'total_amount_promotion'
require 'product_quantity_promotion'

describe 'Checkout Acceptance scenarios' do

  let(:subject) { Checkout.new(promotions) }

  let(:p1) { mock label: 'Travel Card Holder',     price: 9.25 }
  let(:p2) { mock label: 'Personalised cufflinks', price: 45.00 }
  let(:p3) { mock label: 'Kids T-shirt ',          price: 19.95 }

  let(:promotions)        { [over_60_promotion, two_holders_promotion] }
  let(:over_60_promotion) { TotalAmountPromotion.new(60, 0.1) }
  let(:two_holders_promotion)  { ProductQuantityPromotion.new(p1, 2, nil, 8.5) }

  context 'when cart has products 1,2,3' do
    before do
      subject.scan(p1)
      subject.scan(p2)
      subject.scan(p3)
    end
    
    its(:total) { should eq(66.78) }
  end

  context 'when cart has products 1,3,1' do
    before do
      subject.scan(p1)
      subject.scan(p3)
      subject.scan(p1)
    end

    its(:total) { should eq(36.95) }
  end

  context 'when cart has products 1,2,1,3' do
    before do
      subject.scan(p1)
      subject.scan(p2)
      subject.scan(p1)
      subject.scan(p3)
    end

    its(:total) { should eq(73.76) }
  end

end