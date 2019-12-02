# https://leetcode.com/problems/minimum-path-sum/
# @param {Integer[][]} grid
# @return {Integer}
def min_path_sum(grid)
    dynamic_tabulation(grid)
end

def dynamic_tabulation(grid)
    m = grid.size
    n = grid.first.size
    previous_row = grid.last.dup
    (1...n).each do |i|
        previous_row[-i-1] += previous_row[-i]
    end
    
    (1...m).each do |i|
        current_row = grid[-i-1].dup
        current_row[-1] += previous_row[-1]
        (1...n).each do |j|
            current_row[-j-1] += [current_row[-j], previous_row[-j-1]].min
        end
        previous_row=current_row
    end
    previous_row[0]
end

def main()
  p min_path_sum([[1,3,1],[1,5,1],[4,2,1]]) == 7
end
main
