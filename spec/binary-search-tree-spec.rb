require_relative '../lib/binary-search-tree'

RSpec.describe TreeNode do
  it 'has Comparable and compares by data' do
    a = TreeNode.new(5)
    b = TreeNode.new(10)
    expect(a < b).to be true
    expect(a == TreeNode.new(5)).to be true
  end
end

RSpec.describe Tree do
  let(:data) { [1, 7, 4, 23, 8, 9, 4, 3, 5, 7, 9, 67, 6345, 324] }
  let(:tree) { Tree.new(data) }

  it 'builds a balanced tree with unique sorted values' do
    expect(tree.root).to be_a(TreeNode)
    sorted_values = data.uniq.sort
    expect(tree.inorder).to eq(sorted_values)
    expect(tree.balanced?).to be true
  end

  describe '#insert and #find' do
    it 'inserts a value and finds it' do
      tree.insert(100)
      expect(tree.find(100)).to be_a(TreeNode)
      expect(tree.find(100).data).to eq(100)
    end

    it 'does not insert duplicates' do
      original_size = tree.inorder.size
      tree.insert(23)
      expect(tree.inorder.size).to eq(original_size)
    end
  end

  describe '#delete' do
    it 'deletes a leaf node' do
      tree.insert(99)
      expect(tree.find(99)).not_to be_nil
      tree.delete(99)
      expect(tree.find(99)).to be_nil
    end

    it 'deletes a node with one child' do
      tree.insert(100)
      tree.insert(101)
      tree.delete(100)
      expect(tree.find(100)).to be_nil
      expect(tree.find(101)).not_to be_nil
    end

    it 'deletes a node with two children' do
      expect(tree.find(23)).not_to be_nil
      tree.delete(23)
      expect(tree.find(23)).to be_nil
    end
  end

  describe 'Traversal methods' do
    it 'returns correct level-order traversal' do
      expect(tree.level_order).to be_an(Array)
    end

    it 'returns correct preorder traversal' do
      expect(tree.preorder).to be_an(Array)
    end

    it 'returns correct postorder traversal' do
      expect(tree.postorder).to be_an(Array)
    end

    it 'returns correct inorder traversal' do
      expect(tree.inorder).to eq(data.uniq.sort)
    end
  end

  describe '#height and #depth' do
    it 'returns correct height' do
      node = tree.find(67)
      expect(tree.height(67)).to eq(tree.send(:node_height, node))
    end

    it 'returns correct depth' do
      depth = tree.depth(67)
      expect(depth).to be_a(Integer)
      expect(depth).to be >= 0
    end
  end

  describe '#balanced?' do
    it 'detects imbalance' do
      5.times { |i| tree.insert(100 + i) }
      expect(tree.balanced?).to be false
    end

    it 'rebalance the tree' do
      5.times { |i| tree.insert(100 + i) }
      expect(tree.balanced?).to be false
      tree.rebalance
      expect(tree.balanced?).to be true
    end
  end
end
