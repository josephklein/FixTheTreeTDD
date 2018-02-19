require 'rspec'
require 'tree'

describe Tree do
  let(:tree) { Tree.new }

  it 'should be a Class' do
    expect(described_class.is_a? Class).to eq true
  end

  it 'should age one year at a time' do
    tree.age!
    expect(tree.age).to eq 1
    tree.age!
    expect(tree.age).to eq 2
  end

  it 'should grow apples at age 10' do
    tree.age = 9
    tree.age!
    
    expect(tree.apples.size).to be > 0
  end

  it 'should grow apples every year after age 10' do
    tree.age = 9
    tree.age!
    year_ten_count = tree.apples.size
    tree.age!
    year_eleven_count = tree.apples.size

    expect(year_ten_count).to be < year_eleven_count
  end

  it 'should report if it has apples' do
    expect(tree.any_apples?).to eq false
    tree.apples = 1
    expect(tree.any_apples?).to eq true
  end

  it 'should have apples for picking' do
    tree.apples = [Apple.new("Red")]

    apple = tree.pick_an_apple!
    expect(apple.is_a? Apple).to eq true
  end

  it 'should keep track of apples picked' do
    tree.apples = [Apple.new("Red")]
    tree.pick_an_apple!
    expect(tree.apples.size).to eq 0
  end

  it 'should grow in height with age' do
    starting_height = tree.height
    tree.age!
    expect(tree.height).to be > starting_height
  end

  it 'should die when it turns 100' do 
    tree.age = 99
    expect(tree.dead?).to eq false
    tree.age = 100
    expect(tree.dead?).to eq true
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
