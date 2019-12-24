# https://leetcode.com/problems/sort-list/
# Definition for singly-linked list.
# class ListNode
#     attr_accessor :val, :next
#     def initialize(val)
#         @val = val
#         @next = nil
#     end
# end

# @param {ListNode} head
# @return {ListNode}
def sort_list(head)
    travse_sort(head) 
end

def travse_sort(head)
    return head if head.nil? || head.next.nil?
    
    previous = nil
    slow = head
    fast = head
    # let slow travel half the speed of fast
    # so when fast reach the end of list
    # slow will be half of the list
    # making it a merge sort
    while(fast && fast.next)
        previous = slow
        slow = slow.next
        fast = fast.next.next
    end
    
    previous.next = nil if previous
    #p "head %d, slow %d " % [head.val, slow.val]
    
    left = travse_sort(head)
    right = travse_sort(slow)
    merge(left, right)
end

def array_merge_sort(head)
    items = []
    current = head
    while(current)
        items << current
        temp, current.next = current.next, nil
        current = temp
    end
    merge_sort(0,items.size - 1, items)
end

def merge_sort(start_index, end_index, items)
    return nil if start_index > end_index || start_index < 0 || end_index >= items.size
    return items[start_index] if start_index == end_index
    mid = (start_index + end_index) / 2
    # p "#{start_index}, #{end_index}, #{mid}"
    left_sorted = merge_sort(start_index, mid, items)
    right_sorted = merge_sort(mid + 1, end_index, items)
    # p "merge start_index %d, end_index %d, mid %d" % [start_index, end_index, mid]
    merge(left_sorted, right_sorted)
end

def merge(left, right)
    return (left || right) if (left.nil? || right.nil?)
    if left.val > right.val
        right.next = merge(left, right.next)
        return right
    else
        left.next = merge(left.next, right)
        return left
    end
end
