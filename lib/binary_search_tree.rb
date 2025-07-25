# frozen_string_literal: true

require_relative 'treenode'

class Tree
  attr_accessor :root

  def initialize(array)
    @root = build_tree(array)
  end

  def build_tree(array)
    node = nil
    array.each do |item|
      node = insert(node, item)
    end
    node
  end

  def inorder(node = @root, result = [])
    return result if node.nil?

    inorder(node.left, result)
    result << node.value
    inorder(node.right, result)
    result
  end

  # rubocop:disable Metrics/MethodLength, Metrics/CyclomaticComplexity, Metrics/PerceivedComplexity
  def delete(node, target)
    return nil if node.nil?

    if target < node.value
      node.left = delete(node.left, target)
    elsif target > node.value
      node.right = delete(node.right, target)
    elsif node.left.nil? && node.right.nil?
      # Node to delete found
      return nil
    elsif node.left.nil?
      return node.right
    elsif node.right.nil?
      return node.left
    else
      # Two children
      successor = find_successor(node.right)
      node.value = successor.value
      node.right = delete(node.right, successor.value)
    end

    node
  end
  # rubocop:enable Metrics/MethodLength, Metrics/CyclomaticComplexity, Metrics/PerceivedComplexity

  def find_successor(node)
    return node if node.left.nil?

    find_successor(node.left)
  end

  def insert(node, value)
    return TreeNode.new(value) if node.nil?

    if value < node.value
      node.left = insert(node.left, value)
    elsif value > node.value
      node.right = insert(node.right, value)
    end
    node
  end

  def pretty_print(node = @root, prefix = '', is_left = true)
    return if node.nil?

    pretty_print(node.right, "#{prefix}#{is_left ? '│   ' : '    '}", false)
    puts "#{prefix}#{is_left ? '└── ' : '┌── '}#{node.value}"
    pretty_print(node.left, "#{prefix}#{is_left ? '    ' : '│   '}", true)
  end
end
