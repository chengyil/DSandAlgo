# https://leetcode.com/problems/unique-paths/
# @param {Integer} m
# @param {Integer} n
# @return {Integer}
def unique_paths(m, n)
   dynamic_tabulation_optimze(m,n)
end

def dynamic_tabulation_optimze(m, n)
    cache = [1] * n
    (1...m).each do |i|
        (1...n).each do |j|
            cache[-j-1] += cache[-j]
        end
    end
    cache[0]
end

def dynamic_tabulation(m, n)
    cache = []
    cache[m-1] = [1] * n
    (0...m).each {|index| cache[index]||=[]; cache[index][n-1] = 1}
    (1...m).each do |i|
        (1...n).each do |j|
            cache[-i-1][-j-1] = cache[-i-1][-j] + cache[-i][-j-1]
        end
    end
    cache[0][0]
end

def by_bactrack(m, n)
    @count = 0
    backtrack(0, 0, m-1, n -1)
    @count
end

def backtrack(cur_m, cur_n, m, n)
    if cur_m == m && cur_n == n
        @count += 1
        return
    end
    if cur_m + 1 <= m
        backtrack(cur_m + 1, cur_n, m, n)
    end
    if cur_n + 1 <= n
        backtrack(cur_m, cur_n + 1, m, n)
    end
end

def main
  p unique_paths(3,2) == 3
end

main
