# frozen_string_literal: true

# Node class for out Binary Search Tree
class Node
  include Comparable

  attr_accessor :left, :right, :value

  def initialize(value)
    @left = nil
    @right = nil
    @value = value
  end

  def <=>(other)
    value <=> other.value
  end
end
