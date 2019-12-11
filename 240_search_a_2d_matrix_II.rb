# @param {Integer[][]} matrix
# @param {Integer} target
# @return {Boolean}
def search_matrix(matrix, target)
    m = matrix.size
    return false if m.zero?
    n = matrix.first.size
    return false if n.zero?
    row, col = 0, matrix.first.size - 1
    while(row < m && row >= 0 && col < n && col >= 0)
        if matrix[row][col] == target
            return true
        elsif matrix[row][col] > target
            col -= 1
        elsif matrix[row][col] < target
            row +=1
        end
    end
    return false
end

def main
  p search_matrix([[1,4,7,11,15],[2,5,8,12,19],[3,6,9,16,22],[10,13,14,17,24],[18,21,23,26,30]], 5)
end

main
