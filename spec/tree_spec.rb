require 'rspec'
require 'tree'

describe Tree do
  let(:young_tree) { Tree.new 2 }
  let(:fruitful_tree) { Tree.new 11 }
  let(:dead_tree) { Tree.new 100 }

  it 'should be a Class' do
    expect(described_class.is_a? Class).to eq true
  end

  context 'when the tree is younger than 10' do

    it 'should not grow apples' do
      young_tree.age!
      expect(young_tree.apples.size).to eq 0
    end

    it 'should age one year at a time' do
      young_tree.age!
      expect(young_tree.age).to eq 3
      young_tree.age!
      expect(young_tree.age).to eq 4
    end

    it 'should grow apples at age 10' do
      expect(young_tree.apples.size).to eq 0

      young_tree.age = 9
      young_tree.age!

      expect(young_tree.apples.size).to be > 0
    end

    it 'should grow in height with age' do
      starting_height = young_tree.height
      young_tree.age!
      expect(young_tree.height).to be > starting_height
    end

  end

  context 'when the tree is >= 10 and < 100 years old' do

    it 'should age one year at a time' do
      fruitful_tree.age!
      expect(fruitful_tree.age).to eq 12
      fruitful_tree.age!
      expect(fruitful_tree.age).to eq 13
    end

    it 'should grow apples every year' do
      fruitful_tree.age!

      number_of_apples = fruitful_tree.apples.size
      expect(number_of_apples).to be > 0

      fruitful_tree.age!
      expect(fruitful_tree.apples.size).to be > number_of_apples
    end

    it 'should grow in height with age' do
      starting_height = fruitful_tree.height
      fruitful_tree.age!
      expect(fruitful_tree.height).to be > starting_height
    end

    it 'should report that it is alive' do
      expect(fruitful_tree.dead?).to eq false
    end

    context 'when it has apples' do

      it 'should report it has apples' do
        fruitful_tree.apples = [Apple.new("Red")]
        expect(fruitful_tree.any_apples?).to eq true
      end

      it 'should have apples for picking' do
        fruitful_tree.apples = [Apple.new("Red")]

        apple = fruitful_tree.pick_an_apple!
        expect(apple.is_a? Apple).to eq true
      end

      it 'should keep track of apples picked' do
        fruitful_tree.apples = [Apple.new("Red")]
        fruitful_tree.pick_an_apple!
        expect(fruitful_tree.apples.size).to eq 0
      end

    end

    context 'when it has no apples' do

      it 'should raise apple picked' do
        expect{fruitful_tree.pick_an_apple!}.to raise_error
      end

      it 'should report no apples' do
        expect(fruitful_tree.any_apples?).to eq false
      end

    end

  end

  context 'when the tree is 100 or older' do

    it 'should not age' do
      expect{dead_tree.age!}.to raise_error
    end

    it 'should report that it is dead' do
      expect(dead_tree.dead?).to eq true
    end

  end

end

describe 'Fruit' do
end

describe 'Apple' do
  let(:apple) {Apple.new("Red")}

  it 'should have random diameter between 5 and 10 inches' do
    expect(apple.diameter).to be >= 5
    expect(apple.diameter).to be <= 10
  end

end
