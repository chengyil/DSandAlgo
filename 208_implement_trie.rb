require 'forwardable'
class Trie
    class Node
        extend Forwardable
        
        attr_reader :children, :end_of_node
        def_delegators :@children, :[], :[]=
            
        def initialize
            @children = {}
            @end_of_node = false
        end
        
        def mark_as_ended
            @end_of_node = true
        end
        
        def end?
            end_of_node
        end
    end
    attr_reader :root
=begin
    Initialize your data structure here.
=end
    def initialize()
        @root = Trie::Node.new
    end

=begin
    Inserts a word into the trie.
    :type word: String
    :rtype: Void
=end
    def insert(word)
        node = root
        word.chars do |char|
            if node[char].nil?
                node[char] = Trie::Node.new
            end
            node = node[char]
        end
        node.mark_as_ended
        nil
    end

=begin
    Returns if the word is in the trie.
    :type word: String
    :rtype: Boolean
=end
    def search(word)
        node = root
        word.chars.each do |char|
            if node[char]
                node = node[char]
            else
                return false
            end
        end
        node.end?
    end


=begin
    Returns if there is any word in the trie that starts with the given prefix.
    :type prefix: String
    :rtype: Boolean
=end
    def starts_with(prefix)
        node = root
        prefix.chars.each do |char|
            if node[char]
                node = node[char]
            else
                return false
            end
        end
        true
    end
end

# Your Trie object will be instantiated and called as such:
# obj = Trie.new()
# obj.insert(word)
# param_2 = obj.search(word)
# param_3 = obj.starts_with(prefix)
