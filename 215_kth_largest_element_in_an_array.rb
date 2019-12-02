# https://leetcode.com/problems/kth-largest-element-in-an-array/
# @param {Integer[]} nums
# @param {Integer} k
# @return {Integer}
def find_kth_largest(nums, k)
    max_heap(nums, k)
end

def find_by_partition(nums, k)
    nums = nums.sort.reverse
    k = nums.count - k
    low = 0
    high = nums.count - 1
    while(low < high)
        j = partition(nums, low, high)
        if j > k
            high -= 1
        elsif j < k
            low += 1
        else
            break
        end
    end
    nums[k]
end

def partition(nums, low, high)
    i = low
    j = high + 1
    while(true)
        while(i < high)
            i+=1
            break if nums[low] < nums[i]
        end
        while(j > low)
            j-=1
            break if nums[low] > nums[j]
        end
        break if i >= j
        nums[i], nums[j] = nums[j], nums[i]
    end
    nums[low],nums[j]=nums[j],nums[low]
    j
end

def max_heap(nums, k)
    heap = Heap.new()
    nums.each {|num| heap.add(num) }
    ans = nil
    k.times { ans = heap.poll }
    ans
end

require 'forwardable'
class Heap
    extend Forwardable
    
    attr_reader :data
    def_delegator @data, :[], :count
    
    def initialize(values = [])
        @data = values
    end
    
    def root
        0
    end
    
    def last
        @data.count - 1
    end
    
    def left(index)
        if index * 2 + 1 < @data.count
           index * 2 + 1
        else
            nil
        end
    end
    
    def right(index)
        if index * 2 + 2 < @data.count
           index * 2 + 2
        else
            nil
        end
    end
    
    def parent(index)
        if (index - 1) / 2 >= 0
            (index - 1) / 2
        else
            0
        end
    end
    
    def swap(child_index, parent_index)
        @data[child_index], @data[parent_index] = @data[parent_index], @data[child_index]    
    end
    
    def add(value)
        @data.push(value)
        heapify_up
    end
    
    def heapify_up
        node_index = last
        parent_index = nil
        while @data[node_index] > @data[parent_index = parent(node_index)]
            swap(node_index, parent_index)
            node_index = parent_index
        end
    end
    
    def poll
        swap(root, last)
        value = @data.pop
        heapify_down
        value
    end
    
    def heapify_down
        node_index = root
        while left_index = left(node_index)
            bigger_node_index = left_index
            right_index = right(node_index)
            if right_index &&  @data[right_index] > @data[left_index]
                bigger_node_index = right_index
            end
            if @data[bigger_node_index] > @data[node_index]
                swap(bigger_node_index, node_index)
                node_index = bigger_node_index
            else
                break
            end
        end
    end
end

def main
  p find_kth_largest([3,2,1,5,6,4], 2) == 5
end

main
