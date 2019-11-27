class Heap
  class Node
    attr_accessor :index, :heap
    def initialize(index, heap)
      @index = index
      @heap = heap
    end

    def val
      @heap[index]
    end

    def left
      if index*2+1 < @heap.count
        @left ||= Node.new(index*2+1, @heap)
      else
        nil
      end
    end

    def right
      if index*2+2 < @heap.count
        @right ||= Node.new(index*2+2, @heap)
      else
        nil
      end
    end

    def parent
      @parent ||= Node.new((index-1) / 2, @heap)
    end
  end

  attr_reader :data

  def initialize(values)
    @data = values
  end

  def root_node
    Node.new(0,self)
  end

  def [](index)
    @data[index]
  end

  def size
    @data.size
  end

  def count
    @data.count
  end
end

heap = Heap.new([1,2,3,4,5,6,7,8,9,10])
root = heap.root_node
p root.left.left.left.parent.right.val
