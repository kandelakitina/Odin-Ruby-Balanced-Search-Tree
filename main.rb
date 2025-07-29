# frozen_string_literal: true

require_relative 'lib/binary_search_tree'

unbalanced_tree = Tree.new([10, 5, 15])
unbalanced_tree.insert(2)
unbalanced_tree.insert(1)

unbalanced_tree.pretty_print
