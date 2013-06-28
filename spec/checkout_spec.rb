require 'checkout'

describe Checkout do
  subject { Checkout.new(promotions) }

  let(:promotions) {[]}
  let(:calculator) { mock total_amount: 666 }


  describe '#scan' do
    it 'adds a product to the cart ' do
      Cart.any_instance.should_receive(:add).with("product")
      subject.scan "product"
    end
  end

  describe '#total' do
    it 'instantiates cart calculator and returns total amount' do
      CartCalculator.should_receive(:new)
        .with(instance_of(Enumerator), promotions)  
        .and_return(calculator)
      subject.total.should eq(666)
    end
  end
end