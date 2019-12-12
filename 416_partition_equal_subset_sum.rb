# @param {Integer[]} nums
# @return {Boolean}
def can_partition(nums)
    knapsack_set(nums)
end

def knapsack_iterative(nums)
    sum = nums.reduce(&:+)
    return false if sum.odd?
    half = sum / 2
    return true if nums.any? { |num| num == half }
    return false if nums.any? { |num| num > half }
    knapsack_tabulations = []
    knapsack_tabulations << [false] * (half + 1)
    # sum of 0 is 0, so 0 is true
    knapsack_tabulations[0][0] = true
    # value of num for each row is true
    nums.each do |num|
        row = [false] * (half + 1)
        row[0] = row[num] = true
        knapsack_tabulations << row
    end
    
    (1...knapsack_tabulations.size).each do |row|
        (1...knapsack_tabulations.first.size).each do |column|
            knapsack_tabulations[row][column] = knapsack_tabulations[row - 1][column]
            if column >= nums[row-1]
                knapsack_tabulations[row][column] ||= knapsack_tabulations[row - 1][column - nums[row-1]]
            end
        end
    end
    knapsack_tabulations[nums.size][half]
end

def knapsack_set(nums)
    sum = nums.reduce(&:+)
    return false if sum.odd?
    half = sum / 2
    return true if nums.any? { |num| num == half }
    return false if nums.any? { |num| num > half }
    # Set of 0 Item, Sum is 0
    previous_set = [0]
    # With introduction of each new item
    # Add sum to each item in the set
    # Then combine the previous set + new sum after the new item has been added
    # Remove duplicated records
    # Return true if any set contains our sum
    nums.each_index do |index|
        num = nums[index]
        set = []
        previous_set.each do |subset|
            if subset + num <= half
                set << (subset + num)
            end
        end
        return true if set.any? {|subset| subset == half}
        set = previous_set + set
        previous_set = set.uniq
    end
    return false
end


def backtrack(nums)
    sum = nums.reduce(&:+)  
    # 2 equal partitions, if it is not divisble by 2, then there should not be 2 equal partitions
    return false if sum % 2 != 0
    sum /= 2
    nums = nums.sort
    backtrack_downwards(0, sum, nums)
end

def backtrack_downwards(start_index, max_sum, nums)
    return false if start_index > nums.size - 1
    return true if nums[start_index] == max_sum
    return false if max_sum < nums[start_index]
    backtrack_downwards(start_index + 1, max_sum - nums[start_index], nums) || backtrack_downwards(start_index + 1, max_sum, nums)
end

def main
  p can_partition([1,5,5,9])
end

main
