# https://leetcode.com/problems/permutations/
# @param {Integer[]} nums
# @return {Integer[][]}
def permute(nums)
    generate_permutate_via_backtracking(nums)
end

def generate_permutate_via_backtracking(nums)
    @temp_value = []
    @results = []
    step(nums)
    return @results
end

def step(nums)
    if @temp_value.size == nums.size
        @results << @temp_value.dup
        return
    end
    nums.each do |num|
        if valid?(num)
            update(num)
            @temp_value.push(num)
            step(nums)
            @temp_value.pop
            update(num)
        end
    end
end

def valid?(value)
    @set ||={}
    @set[value] != true
end

def update(value)
    @set ||={}
    @set[value]=!@set[value]
end

def generate_permutate_via_previous_generation(nums)
    permutations = [[[nums.first]]]
    (1...nums.size).each do |i|
        permutations[i]=[]
        permutations[i-1].each do |item|
            (0..i).each do |j|
               permutations[i] << item.dup.insert(j, nums[i])
            end
        end
    end
    permutations[nums.size-1]
end

def main
  p permute([1,2,3])
end

main
