# https://leetcode.com/problems/combination-sum/
# @param {Integer[]} candidates
# @param {Integer} target
# @return {Integer[][]}
def combination_sum(candidates, target)
    backtrack([],[],candidates,target, 0)
end

def backtrack(answers, current, candidates, target, start)
    if target.zero?
        answers << current.dup
        return answers
    elsif target < 0
        return answers
    end
    (start...candidates.size).each do |index|
        backtrack(answers, current + [candidates[index]], candidates, target - candidates[index], index)
    end
    answers
end

def main
  ans = combination_sum([2,3,6,7], 7) - [[2,2,3],[7]] 
  p ans.empty?
end

main
