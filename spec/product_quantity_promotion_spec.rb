require 'product_quantity_promotion'

describe ProductQuantityPromotion do
  subject { ProductQuantityPromotion.new(product, quantity, discount) }
  let(:product) { Struct.new(:price)[5] }
  let(:quantity)  { 10 }
  let(:discount)  { 0.20 }

  its(:item_based?) { should be_true }
  its(:total_based?) { should be_false }

  context 'when defined as discount' do
    its(:discount)         { should eq(0.2) }
    its(:discounted_price) { should be_nil }
  end

  context 'when defined as discounted price' do
    subject { ProductQuantityPromotion.new(product, quantity, nil, new_price) }
    let(:quantity)  { 10 }
    let(:new_price) { 4.5 }

    its(:discount)         { should be_nil }
    its(:discounted_price) { should eq(new_price) }
  end


  describe '#applicable_to?' do
    context 'when right product and quantity equal or greater than defined' do
      it 'returns true' do
        subject.applicable_to?(product, 10).should be_true
      end
    end

    context 'when quantity not big enough or wrong product' do
      it 'returns false' do
        subject.applicable_to?(product, 9).should be_false
        subject.applicable_to?("other", 12).should be_false
      end
    end
  end
end