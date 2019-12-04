# Definition for a binary tree node.
# class TreeNode
#     attr_accessor :val, :left, :right
#     def initialize(val)
#         @val = val
#         @left, @right = nil, nil
#     end
# end

# @param {TreeNode} root
# @return {Void} Do not return anything, modify root in-place instead.
def flatten(root)
    step(root)
    root
end

def step(node)
    return node if node.nil?
    left, node.left = node.left, nil
    right, node.right = node.right, nil
    last_node = node
    
    if left
        last_node.right = left
        last_node = left
        last_node = step(last_node)
    end
    if right
        last_node.right = right
        last_node = right
        last_node = step(last_node)
    end
    return last_node
end
