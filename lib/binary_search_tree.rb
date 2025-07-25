# frozen_string_literal: true

require_relative 'treenode'

class Tree
  def initialize(array)
    @root = TreeNode.new(array[array.size / 2])
    build_tree(array, @root)
  end

  def build_tree(array, node = nil)
    array.each do |item|
      insert(node, item)
    end
    node
  end

  def pretty_print(node = @root, prefix = '', is_left = true)
    pretty_print(node.right, "#{prefix}#{is_left ? '│   ' : '    '}", false) if node.right
    puts "#{prefix}#{is_left ? '└── ' : '┌── '}#{node.value}"
    pretty_print(node.left, "#{prefix}#{is_left ? '    ' : '│   '}", true) if node.left
  end

  # def in_order(node, result = [])
  #   return result if node.nil?

  #   in_order(node.left, result)
  #   result << node.value
  #   in_order(node.right, result)
  #   result
  # end

  private

  def insert(node, value)
    return TreeNode.new(value) if node.nil?

    if value < node.value
      node.left = insert(node.left, value)
    elsif value > node.value
      node.right = insert(node.right, value)
    end
    node
  end
end
