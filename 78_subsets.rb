# https://leetcode.com/problems/subsets/
# @param {Integer[]} nums
# @return {Integer[][]}
def subsets(nums)
    backtrack([], [], 0, nums)
end

def backtrack(ans, current, start, nums)
    ans << current.dup
   (start...nums.size).each do |index|
        backtrack(ans, current + [nums[index]], index+1, nums)
   end
   ans
end

def main
  ans = subsets([1,2,3]) - [
    [3],
    [1],
    [2],
    [1,2,3],
    [1,3],
    [2,3],
    [1,2],
    []
  ]
  p  ans.empty?
end
main
