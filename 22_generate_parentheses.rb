# https://leetcode.com/problems/generate-parentheses/
# @param {Integer} n
# @return {String[]}
def generate_parenthesis(n)
    backtracking(n)
end

def backtracking(n)
    step([], '', 0, 0, n)
end
    
def step(answers, current, open, close, max)
    if current.length == max * 2
      answers << current
      return answers
    end
    if open < max
        step(answers, current+'(', open+1, close, max)
    end
    if close < open
        step(answers, current+')', open, close+1, max)
    end
    return answers
end

def main
  puts (generate_parenthesis(3) - ["((()))","(()())","(())()","()(())","()()()"]).empty?
end

main
