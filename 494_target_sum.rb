# https://leetcode.com/problems/target-sum/
# @param {Integer[]} nums
# @param {Integer} s
# @return {Integer}
def find_target_sum_ways(nums, s)
    dp(nums, s)
end

def subset(nums, s)
    # s = sum(P) - sum(N)
    # sum(P) + sum(N) + s = sum(P) - sum(N) + sum(P) + sum(N)
    # sum(nums) + s = sum(P) * 2
    sums = nums.reduce(&:+)
    return 0 if sums < s || (sums + s) % 2 != 0
    sum_p = (sums + s) >> 1
    cache = [1]
    nums.each do |num|
        i = sum_p
        while(i >= num)
            cache[i] = (cache[i] || 0) + (cache[i - num] || 0)
            i -=1
        end
    end
    cache[sum_p]
end

def dp(nums, s)
    step(0,0,nums,s,[])
end

def step(current, start_index, nums, s, map)
    if start_index == nums.size
        if current == s
            return 1
        else
            return 0
        end
    end
    # At any given index, if we have calculated this sum before, we can just return the count
    map[start_index] ||= {}
    return map[start_index][current] if !map[start_index][current].nil?
    count_minus = step(current - nums[start_index], start_index + 1, nums, s, map)
    count_plus = step(current + nums[start_index], start_index + 1, nums, s, map)
    map[start_index][current] = count_minus + count_plus
end

def main
  p find_target_sum_ways([1,1,1,1,1], 3) == 5
end

main
