# https://leetcode.com/problems/construct-binary-tree-from-preorder-and-inorder-traversal/
# Definition for a binary tree node.
# class TreeNode
#     attr_accessor :val, :left, :right
#     def initialize(val)
#         @val = val
#         @left, @right = nil, nil
#     end
# end

# @param {Integer[]} preorder
# @param {Integer[]} inorder
# @return {TreeNode}
def build_tree(preorder, inorder)
    optimize(preorder, inorder)
end

def optimize(preorder, inorder)
    inorder_map = {}
    inorder.each.with_index {|value, index| inorder_map[value] = index }
    @pre_start = 0
    optimize_build(0, inorder.size-1, preorder, inorder, inorder_map)
end

def optimize_build(in_start, in_end, preorder, inorder, inorder_map)
    if @pre_start >= preorder.size || in_start > in_end
        return nil
    end
    node = TreeNode.new(preorder[@pre_start])
    index = inorder_map[node.val]
    @pre_start +=1
    node.left = optimize_build(in_start, index - 1, preorder, inorder, inorder_map)
    node.right = optimize_build(index + 1, in_end, preorder, inorder, inorder_map)
    node
end
    
def non_optimize(preorder, inorder)
    @preorder_map = {}
    preorder.each.with_index {|value, index| @preorder_map[value] = index }
    @preorder = preorder
    subtree = inorder.dup
    step(subtree)
end


def step(subtree)
    val = find_root_in_subtree(subtree)
    #p "root value #{val}"
    if val
        node = TreeNode.new(val)
        left, right = partition(subtree, val)
        #p "left #{left}"
        #p "right #{right}"
        node.left = step(left)
        node.right = step(right)
        node
    else
        nil
    end
end

def find_root_in_subtree(subtree)
    index = subtree.map { |val| @preorder_map[val] }.min
    if index
        @preorder[index]
    else
        nil
    end
end

def partition(inorder, root)
    left = []
    right = inorder
    while(num = right.shift)
        if num == root
            break
        else
            left << num
        end
    end
    
    return [left, right]
end
