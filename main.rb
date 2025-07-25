# frozen_string_literal: true

require_relative 'lib/binary_search_tree'

mytree = Tree.new([10, 5, 15, 3, 7, 12, 18])
mytree.pretty_print

p mytree.preorder
p mytree.inorder
p mytree.postorder
