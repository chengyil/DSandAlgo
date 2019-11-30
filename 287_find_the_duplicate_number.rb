#https://leetcode.com/problems/find-the-duplicate-number/
# @param {Integer[]} nums
# @return {Integer}
def find_duplicate(nums)
    _, slow_ptr = find_meet_point(nums)
    find_entrance_of_cyclic_loop(slow_ptr, nums)
end

def find_meet_point(nums)
    fast_ptr = slow_ptr = nums[0]
    while((fast_ptr = nums[nums[fast_ptr]]) != (slow_ptr = nums[slow_ptr]))
    end
    [fast_ptr, slow_ptr]
end

def find_entrance_of_cyclic_loop(slow_ptr, nums)
    ptr1 = nums[0]
    ptr2 = slow_ptr
    while(ptr1 != ptr2)
        ptr1 = nums[ptr1]
        ptr2 = nums[ptr2]
    end
    ptr1
end

def main()
  p find_duplicate([1,3,4,2,2]) == 2
end

main

#nums[t]
#0, 1, 2, 3, 4, 5
#1, 2, 3, 4, 5, 3

#num[nums[r]]
#t 1, 2, 3, 4, 5, 3
#h 2, 4, 3

#0, 1, 2, 3, 4, 5
#1, 4, 5, 5, 3, 2

#t 1, 4, 3, 5, 2, 5
#h 4, 5, 2, 2, 2
  
