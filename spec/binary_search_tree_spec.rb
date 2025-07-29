# frozen_string_literal: true

require_relative '../lib/binary_search_tree'

RSpec.describe Tree do
  let(:array) { [10, 5, 15, 3, 7, 12, 18] }
  let(:tree) { described_class.new(array) }

  describe '#initialize' do
    it 'builds a tree with the root value from the first element inserted' do
      expect(tree.root).to be_a(TreeNode)
      expect(tree.root.value).to eq(10)
    end
  end

  describe '#insert' do
    it 'inserts a new node into the tree' do
      tree.insert(6)
      expect(tree.inorder).to include(6)
    end

    it 'does not insert duplicates' do
      original = tree.inorder.dup
      tree.insert(10)
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

  describe '#find' do
    context 'when the target exists in the tree' do
      it 'returns the node with the target value' do
        node = tree.find(tree.root, 7)
        expect(node).to be_a(TreeNode)
        expect(node.value).to eq(7)
      end
    end

    context 'when the target does not exist in the tree' do
      it 'returns nil' do
        result = tree.find(tree.root, 99)
        expect(result).to be_nil
      end
    end

    context 'when the tree is empty' do
      it 'returns nil' do
        empty_tree = Tree.new([])
        expect(empty_tree.find(empty_tree.root, 10)).to be_nil
      end
    end

    context 'when the target is at the root' do
      it 'returns the root node' do
        node = tree.find(tree.root, 10)
        expect(node).to eq(tree.root)
      end
    end
  end

  describe 'traversals' do
    it 'returns the elements in #preorder traversal' do
      expect(tree.preorder).to eq([10, 5, 3, 7, 15, 12, 18])
    end

    it 'returns the elements in #inorder traversal' do
      expect(tree.inorder).to eq([3, 5, 7, 10, 12, 15, 18])
    end

    it 'returns the elements in #postorder traversal' do
      expect(tree.postorder).to eq([3, 7, 5, 12, 18, 15, 10])
    end
  end

  describe '#level_order' do
    context 'when no block is given' do
      it 'returns an array of values in level-order traversal' do
        expect(tree.level_order).to eq([10, 5, 15, 3, 7, 12, 18])
      end
    end

    context 'when a block is given' do
      it 'yields each node in level-order' do
        values = []
        tree.level_order { |node| values << node.value }
        expect(values).to eq([10, 5, 15, 3, 7, 12, 18])
      end

      it 'allows any operation on each node via block' do
        sum = 0
        tree.level_order { |node| sum += node.value }
        expect(sum).to eq(array.sum)
      end
    end
  end

  describe '#height' do
    it 'returns the correct height of the tree' do
      expect(tree.height).to eq(2)
    end

    it 'returns -1 for an empty tree' do
      empty_tree = Tree.allocate
      empty_tree.instance_variable_set(:@root, nil)
      expect(empty_tree.height).to eq(-1)
    end

    it 'returns 0 for a tree with only root node' do
      single_node_tree = Tree.allocate
      single_node = TreeNode.new(42)
      single_node_tree.instance_variable_set(:@root, single_node)
      expect(single_node_tree.height).to eq(0)
    end
  end

  describe '#depth' do
    it 'returns 0 for the root node' do
      expect(tree.depth(tree.root)).to eq(0)
    end

    it 'returns correct depth for a left child' do
      left_child = tree.root.left # node with value 5
      expect(tree.depth(left_child)).to eq(1)
    end

    it 'returns correct depth for a right-right grandchild' do
      right_right = tree.root.right.right # node with value 18
      expect(tree.depth(right_right)).to eq(2)
    end

    it 'returns -1 for a node not in the tree' do
      orphan = TreeNode.new(999)
      expect(tree.depth(orphan)).to eq(-1)
    end
  end

  describe '#balanced?' do
    context 'when the tree is perfectly balanced' do
      it 'returns true' do
        expect(tree.balanced?).to eq(true)
      end
    end

    context 'when the tree is unbalanced due to deeper right subtree' do
      it 'returns false' do
        tree.insert(20)
        tree.insert(25)
        expect(tree.balanced?).to eq(false)
      end
    end

    context 'when the tree is unbalanced due to deeper left subtree' do
      it 'returns false' do
        unbalanced_tree = Tree.new([10, 5, 15])
        unbalanced_tree.insert(2)
        unbalanced_tree.insert(1)
        expect(unbalanced_tree.balanced?).to eq(false)
      end
    end

    context 'when the tree is empty' do
      it 'returns true' do
        empty_tree = Tree.allocate
        empty_tree.instance_variable_set(:@root, nil)
        expect(empty_tree.balanced?).to eq(true)
      end
    end

    context 'when the tree has only one node' do
      it 'returns true' do
        single_node_tree = Tree.new([42])
        expect(single_node_tree.balanced?).to eq(true)
      end
    end
  end

  describe '#clear' do
    it 'removes all nodes from the tree' do
      tree.clear
      expect(tree.root).to be_nil
      expect(tree.inorder).to eq([])
      expect(tree.height).to eq(-1)
      expect(tree.balanced?).to be true
    end
  end
end
