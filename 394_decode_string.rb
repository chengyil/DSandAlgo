# https://leetcode.com/problems/decode-string/
# @param {String} s
# @return {String}
def decode_string(s)
    build(s.chars)
end

def build(chars)
    result = ""
    until(chars.empty?)
        char = chars.shift
        byte = char.bytes.first
        if (byte >= 97 && byte <= 122) || (byte >= 65 && byte <= 90) 
            result += char
        elsif char == ']'
            break
        else
            multiplier = char
            while((char = chars.shift) != '[')
                multiplier+=char
            end
            result += build(chars) * multiplier.to_i
        end
    end
    return result
end

def main
  p decode_string("3[a]2[b4[F]c]") == "aaabFFFFcbFFFFc"
end

main
