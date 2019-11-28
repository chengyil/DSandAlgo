# https://leetcode.com/problems/rotate-image/
# Rotate without additional memory for new matrix
# @param {Integer[][]} matrix
# @return {Void} Do not return anything, modify matrix in-place instead.
def rotate(matrix)
    n = matrix.size
    matrix = reverse(matrix, n)
    mirror_diagonally(matrix, n)
end

def reverse(matrix, n)
    top = 0
    bottom = n -1
    while bottom > top
        matrix[bottom],matrix[top] = matrix[top],matrix[bottom]
        bottom -=1
        top +=1
    end
    matrix
end

def mirror_diagonally(matrix, n)
    (0...n).each do |i|
        (i+1...n).each do |j|
            matrix[i][j], matrix[j][i] = matrix[j][i], matrix[i][j]
        end
    end
    matrix
end

def main
  p rotate([[1,2,3],[4,5,6],[7,8,9]]) == [[7,4,1],[8,5,2],[9,6,3]]
end

main
