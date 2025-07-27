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

  def level_order(node = @root, result = [])
    return result if node.nil?

    queue = [node]

    until queue.empty?
      current = queue.shift
      yield current if block_given?
      result << current.value
      queue << current.left if current.left
      queue << current.right if current.right
    end

    result unless block_given?
  end

  def height(node = @root)
    return -1 if node.nil?

    left = height(node.left)
    right = height(node.right)
    [left, right].max + 1
  end

  def depth(target, current = @root, current_depth = 0)
    return -1 if current.nil?
    return current_depth if current == target

    left = depth(target, current.left, current_depth + 1)
    return left unless left == -1

    depth(target, current.right, current_depth + 1)
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
