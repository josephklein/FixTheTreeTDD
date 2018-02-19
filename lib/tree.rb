class NoApplesError < StandardError; end

class Tree
  attr_accessor :age, :apples, :height

  def initialize (age = 0)
    @age = age
    @apples = []
    @height = 0.0
  end

  def age!
    raise DeadTreeError, "This tree is dead!" unless !self.dead?
    @age += 1
    @height += rand
    if(@age >= 10)
      self.add_apples(1 + rand(2 * @age))
    end
  end

  def add_apples(count = 100)
    count.times do
      @apples.push(Apple.new("Red"))
    end
  end

  def any_apples?
    return apples.size > 0
  end

  def pick_an_apple!
    raise NoApplesError, "This tree has no apples" unless self.any_apples?
    return @apples.pop
  end

  def dead?
    return @age >= 100
  end
end

class Fruit
  def initialize
    has_seeds = true
  end
end

class Apple < Fruit
  attr_reader :color, :diameter

  def initialize(color)
    @color = color
    @diameter =  5 + rand(5)
  end
end

#THERES ONLY ONE THING YOU NEED TO EDIT BELOW THIS LINE
# avg_diameter (line 58) will raise an error.
# it should calculate the diameter of the apples in the basket

def tree_data
  tree = Tree.new

  tree.age! until tree.any_apples?

  puts "Tree is #{tree.age} years old and #{tree.height} feet tall"

  until tree.dead?
    basket = []

    # It places the apple in the basket
    while tree.any_apples?
      basket << tree.pick_an_apple!
    end

    diameter_sum = 0

    basket.each do |apple|
      diameter_sum += apple.diameter
    end

    avg_diameter = diameter_sum / basket.size

    puts "Year #{tree.age} Report"
    puts "Tree height: #{tree.height.round(2)} feet"
    puts "Harvest:     #{basket.size} apples with an average diameter of #{avg_diameter} inches"
    puts ""

    # Ages the tree another year
    tree.age!
  end

  puts "Alas, the tree, she is dead!"
end

# Uncomment this line to run the script, but BE SURE to comment it before you try to run your tests!
# tree_data
