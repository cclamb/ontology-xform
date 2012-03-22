class Node
  attr_accessor :value
  attr_reader :children
  def initialize
    @children = []
  end
  def add_child child
    @children.push child
  end
end

