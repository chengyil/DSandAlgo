# @param {String} s
# @return {Integer}
def count_substrings(s)
    manacher_algorithm(s)
end

# https://www.youtube.com/watch?v=nbTSfrEfo6M
# For a Palindromic string,
# the right side from the center, has the same length as left,
# if the left side of the palindromic string is within the boundary of current center Palidromic String
# else it be Right Most Index of current Palidromic substring - Index of current item
#  Given a string of abababa
#     b
# a(5) a(mirror = 5)
# b(3) b(mirror = 3)
# a(1) a(mirror = 1)

def manacher_algorithm(s)
    manacher_string = ['$','#']
    s.chars.each do |char|
        manacher_string.push(char,'#')
    end
    manacher_string.push '@'
    computed_count = [0]*manacher_string.length
    right = center = 0
    (1...manacher_string.size).each do |index|
        mirror = center * 2 - index
        
        if index < right
            computed_count[index] = [right - index, computed_count[mirror]].min
        end
        
        while(manacher_string[index + (1 + computed_count[index])] == manacher_string[index - (1 + computed_count[index])])
            computed_count[index] += 1
        end
        
        if index + computed_count[index]  > right
            center = index
            right = index + computed_count[index] 
        end
    end
    computed_count.reduce(0) {|s,count| s+=((count+1)/2)}
end

def expand_from_middle(s)
    len = s.length
    count = 0
    (0...(s.length*2)).each do |position|
        # Starting to expands from each possible position in the string
        # there 2 type of expands, odd and even
        # a -> bab -> cbabc
        # aa -> baab -> cbaabc
        # as such, each left index are use twice
        # for odd and even expansion
        left = position / 2
        right = left + position % 2
        while(left >= 0 && right < len && s[left]==s[right])
            count += 1
            left -= 1
            right += 1
        end
    end
    count
end

def main
  p count_substrings('abababa') == 16
end

main
