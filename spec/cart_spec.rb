require 'cart'

describe Cart do  
  before do
    subject.add "a", quantity: 3
    subject.add "b"
    subject.add "c"
    subject.add "d", quantity: 2
    subject.add "c"
  end

  its(:size) { should eq(4) }

  describe '#[]' do
    it 'returns cart items for given product' do
      subject["a"].tap do |a|
        a.product.should eq("a")
        a.quantity.should eq(3)
      end
    end
  end

  describe '#each' do
    it 'returns enumerator over cart items' do
      subject.each.tap do |enum|
        enum.should be_a_kind_of(Enumerator)
        enum.map(&:product).should include(*%w(a b c d))
        enum.map(&:quantity).should include(3,1,2)
      end
    end
  end

  describe '#each_key' do
    it 'returns enumerator over products' do
      subject.each_key.should be_a_kind_of(Enumerator)
      subject.each_key.to_a.should include(*%w(a b c d))
    end
  end
end