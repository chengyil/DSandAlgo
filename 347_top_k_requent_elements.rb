#https://leetcode.com/problems/top-k-frequent-elements/
require 'forwardable'
# @param {Integer[]} nums
# @param {Integer} k
# @return {Integer[]}
def top_k_frequent(nums, k)
    map = {}
    nums.each do |num|
        map[num] = map[num].to_i + 1
    end
    heap = Heap.new()
    map.each do |k,v|
        heap.add(Value.new(k,v))
    end
    
    ans = []
    k.times do
        ans << heap.poll.num
    end
    ans
end

class Value
    include Comparable
    attr_reader :num, :count
    def initialize(num, count)
        @num = num
        @count = count
    end
    def <=>(other)
        self.count <=> other.count
    end
end

class Heap
    extend Forwardable
    class Node
        attr_reader :index, :heap
        def initialize(index, heap)
            @index = index
            @heap = heap
        end
        
        def val
            heap[index]
        end
        
        def left
            if index * 2 + 1 < heap.size
                Node.new(index * 2 + 1, heap)
            else
                nil
            end
        end
        
        def right
            if index * 2 + 2 < heap.size
                Node.new(index * 2 + 2, heap)
            else
                nil
            end
        end
        
        def parent
            if (index-1) / 2 >= 0
                Node.new((index-1) / 2, heap)
            else
                nil
            end
        end
    end
    
    attr_reader :data
    def_delegators :@data, :[], :size, :count 

    def initialize(values = [])
        @data = values
    end
    
    def root
        if size > 0
            Node.new(0, self)
        else
            nil
        end
    end
    
    def last
        if size > 0
            Node.new(size-1, self)
        else
            nil
        end
    end
    
    def add(value)
        data.push(value)
        heapify_up
    end
    
    def swap(child, parent)
        data[child.index],data[parent.index] = data[parent.index],data[child.index]
    end
    
    def heapify_up
        node = last
        while node.parent && node.parent.val < node.val
            swap(node, node.parent)
            node = node.parent
        end
    end
    
    def poll()
        if root
            item = root.val
            swap(root, last)
            data.pop
            heapify_down
            item
        else
            nil
        end
    end
    
    def heapify_down
        return if root.nil?
        node = root
        while(node.left)
            bigger_node = node.left
            if node.right && node.right.val > node.left.val
                bigger_node = node.right
            end
            if bigger_node.val > node.val
                swap(node,bigger_node)
                node=bigger_node
            else
                break
            end
        end
    end
end

def main()
  p ([1,2] - top_k_frequent([1,1,1,2,2,3], 2)).empty? == true
end
main
