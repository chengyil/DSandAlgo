# https://leetcode.com/problems/container-with-most-water/
# @param {Integer[]} height
# @return {Integer}
def max_area(height)
    left_ptr = 0
    right_ptr = height.size - 1
    current_max = 0
    while(left_ptr < right_ptr)
        current_max = [current_max, (right_ptr - left_ptr) * [height[left_ptr], height[right_ptr]].min].max
        if height[left_ptr] > height[right_ptr]
            right_ptr -= 1
        else
            left_ptr +=1
        end
    end
    current_max
end

def main()
  p max_area([1,8,6,2,5,4,8,3,7]) == 49
end

main
