# frozen_string_literal: true

require_relative '../lib/binary_search_tree.rb'

RSpec.describe Tree do
  let(:array) { [10, 5, 15, 3, 7, 12, 18] }
  let(:tree) { described_class.new(array) }

  describe '#initialize' do
    it 'builds a tree with the root value from the first element inserted' do
      expect(tree.root).to be_a(TreeNode)
      expect(tree.root.value).to eq(10)
    end
  end

  describe '#inorder' do
    it 'returns the elements in sorted order' do
      expect(tree.inorder).to eq([3, 5, 7, 10, 12, 15, 18])
    end
  end

  describe '#insert' do
    it 'inserts a new node into the tree' do
      tree.insert(tree.root, 6)
      expect(tree.inorder).to include(6)
    end

    it 'does not insert duplicates' do
      original = tree.inorder
      tree.insert(tree.root, 10)
      expect(tree.inorder).to eq(original)
    end
  end

  describe '#delete' do
    context 'when deleting a leaf node' do
      it 'removes the node' do
        tree.delete(tree.root, 3)
        expect(tree.inorder).not_to include(3)
      end
    end

    context 'when deleting a node with one child' do
      it 'replaces the node with its child' do
        tree.delete(tree.root, 5)
        expect(tree.inorder).to eq([3, 7, 10, 12, 15, 18])
      end
    end

    context 'when deleting a node with two children' do
      it 'replaces it with its inorder successor' do
        tree.delete(tree.root, 10)
        expect(tree.inorder).to eq([3, 5, 7, 12, 15, 18])
      end
    end

    context 'when deleting the root node until empty' do
      it 'returns nil when deleting from an empty tree' do
        empty_tree = Tree.new([])
        expect(empty_tree.delete(empty_tree.root, 1)).to be_nil
      end
    end
  end

  describe '#find_successor' do
    it 'finds the smallest value in the right subtree' do
      node = tree.root.right # value: 15
      successor = tree.find_successor(node)
      expect(successor.value).to eq(12)
    end
  end
end
