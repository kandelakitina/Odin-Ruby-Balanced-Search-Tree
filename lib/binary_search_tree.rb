# frozen_string_literal: true

require_relative 'treenode'

class Tree
  attr_accessor :root

  def initialize(array)
    @root = build_tree(array.uniq.sort)
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

  def find(node, target)
    return nil if node.nil?
    return node if node.value == target

    if target < node.value
      find(node.left, target)
    else
      find(node.right, target)
    end
  end

  # Traversal methods
  def inorder(node = @root, result = [])
    return result if node.nil?

    inorder(node.left, result)
    result << node.value
    inorder(node.right, result)
    result
  end

  def preorder(node = @root, result = [])
    return result if node.nil?

    result << node.value
    preorder(node.left, result)
    preorder(node.right, result)
    result
  end

  def postorder(node = @root, result = [])
    return result if node.nil?

    postorder(node.left, result)
    postorder(node.right, result)
    result << node.value
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
    return nil if array.empty?

    mid = array.size / 2
    node = TreeNode.new(array[mid])
    node.left = build_tree(array[0...mid])
    node.right = build_tree(array[(mid + 1)..])
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
