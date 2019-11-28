# https://leetcode.com/problems/product-of-array-except-self/
# We are advise not to use divide
# @param {Integer[]} nums
# @return {Integer[]}
def product_except_self(nums)
    o_one_space(nums)
end

def o_one_space(nums)
    ans = [1]
    (1...nums.size).each do |index|
        ans[index] = nums[index-1] * ans[index-1]
    end
    
    right = 1
    (1...nums.size).each do |index|
        right = right * nums[-index]
        ans[-index-1] = right * ans[-index-1]
    end
    ans
end

# at any index, the total sum is left of sum of index by sum of right of index
# Precalcuate the left total sum of each index
# Precalcuate the right total sum of each index
# Sum each index together
def dynamic_programming(nums)
    left = [1]
    right = [1]

    (1...nums.size).each do |index|
        left[index] = nums[index-1] * left[index-1]
        right.unshift(nums[-index] * right.first)
    end
    

    ans = []
    (0...nums.size).each do |index|
        ans << left[index] * right[index]
    end
    ans
end

def main
  p product_except_self([1,2,3,4]) == [24,12,8,6]
end

main
