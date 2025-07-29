# frozen_string_literal: true

require_relative 'lib/binary_search_tree'

# Helper to print traversal results
def print_traversals(tree)
  puts "Level-order:  #{tree.level_order}"
  puts "Preorder:     #{tree.preorder}"
  puts "Postorder:    #{tree.postorder}"
  puts "Inorder:      #{tree.inorder}"
end

# Step 1: Create tree from 15 random numbers
array = Array.new(15) { rand(1..100) }
puts "Initial array: #{array.inspect}"
tree = Tree.new(array)

# Step 2: Confirm tree is balanced
puts "\nBalanced? #{tree.balanced?}" # should be true

# Step 3: Print traversals
puts "\nInitial traversals:"
print_traversals(tree)

# Step 4: Unbalance the tree
[101, 120, 130, 140, 150].each { |val| tree.insert(val) }

# Step 5: Confirm tree is unbalanced
puts "\nBalanced after inserts? #{tree.balanced?}" # should be false

# Step 6: Rebalance the tree
tree.rebalance

# Step 7: Confirm tree is balanced again
puts "\nBalanced after rebalance? #{tree.balanced?}" # should be true

# Step 8: Print traversals again
puts "\nTraversals after rebalance:"
print_traversals(tree)
