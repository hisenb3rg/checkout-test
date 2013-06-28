require 'total_amount_promotion'

describe TotalAmountPromotion do
  subject { TotalAmountPromotion.new(amount, discount) }
  let(:amount)   { 100.10 }
  let(:discount) { 0.20 }

  its(:item_based?)  { should be_false }
  its(:total_based?) { should be_true }

  describe '#discount' do
    it 'returns given discount' do
      subject.discount.should eq(discount)
    end
  end

  describe '#applicable_to?' do
    context 'when amount equal or greater than min amount' do
      it 'returns true' do
        subject.applicable_to?(101).should be_true
      end
    end

    context 'when amount lower that that' do
      it 'returns false' do
        subject.applicable_to?(100.09).should be_false
      end
    end
  end
end