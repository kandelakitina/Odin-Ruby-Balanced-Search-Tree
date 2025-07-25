# frozen_string_literal: true

require_relative 'treenode'

class Tree
  attr_accessor :root

  def initialize(array)
    @root = build_tree(array)
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

  def delete(node, target)
    return nil if node.nil?

    if target < node.value
      node.left = delete(node.left, target)
    elsif target > node.value
      node.right = delete(node.right, target)
    else
      node = delete_node(node)
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

  def pretty_print(node: @root, prefix: '', is_left: true)
    return if node.nil?

    pretty_print(node: node.right, prefix: "#{prefix}#{is_left ? '│   ' : '    '}", is_left: false)
    puts "#{prefix}#{is_left ? '└── ' : '┌── '}#{node.value}"
    pretty_print(node: node.left, prefix: "#{prefix}#{is_left ? '    ' : '│   '}", is_left: true)
  end

  private

  def build_tree(array)
    node = nil
    array.each do |item|
      node = insert(node, item)
    end
    node
  end

  def delete_node(node)
    return nil if leaf?(node)
    return node.right if node.left.nil?
    return node.left if node.right.nil?

    # Node has two children
    successor = find_successor(node.right)
    node.value = successor.value
    node.right = delete(node.right, successor.value)
    node
  end

  def leaf?(node)
    node.left.nil? && node.right.nil?
  end

  def find_successor(node)
    return node if node.left.nil?

    find_successor(node.left)
  end
end
