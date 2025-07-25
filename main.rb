# frozen_string_literal: true

require_relative 'lib/binary_search_tree'

mytree = Tree.new([10, 5, 15, 3, 7, 12, 18])
mytree.pretty_print

puts 'preorder'
p mytree.preorder

puts 'inorder'
p mytree.inorder

puts 'postorder'
p mytree.postorder

puts 'level order'
p mytree.level_order
