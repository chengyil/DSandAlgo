# @param {Integer[]} nums
# @param {Integer} k
# @return {Integer}
def subarray_sum(nums, k)
    presum(nums, k)
end

def presum(nums, k)
    # sum[i..j] = sum[0..j] - sum[0..i]
    # sum[0..i] = sum[0..j] - sum[i..j]
    # sum[0..i] = sum[0..j] - k
    # previous_sum = current_sum_til_j - k
    # count of times previous_sum =  current_sum_til_j - k
    presum = 0
    presums = {0 => 1}
    count = 0
    nums.each do |num|
        presum += num
        count += presums[presum - k] if presums[presum - k]
        presums[presum] = presums[presum] ? presums[presum] + 1 : 1
    end
    count
end

def accum_sum(nums, k)
    count = 0
    sum = [0]
    size = nums.size
    nums.each_index do |index|
        sum[index + 1] = sum[index] + nums[index]
    end
    (0...size).each do |start_index|
        start = start_index+1
        (start..size).each do |end_index|
            count += 1 if sum[end_index] - sum[start_index] == k
        end
    end
    count
end

def brute_force(nums, k)
    count = 0
    nums.each_index do |i|
        ((i+1)...nums.size).each do |j|
            current_sum = 0
            (i..j).each do |kk|
                current_sum += nums[kk]
            end
            count +=1 if current_sum == k
        end
    end
    count
end

def main
  p subarray_sum([1,1,1,1,1], 2) == 4
end
main
