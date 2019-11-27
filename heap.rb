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
      if (index - 1) / 2 >= 0
        @parent ||= Node.new((index-1) / 2, @heap)
      else
        nil
      end
    end
  end

  attr_reader :data

  def initialize(values)
    @data = values
  end

  def root
    Node.new(0,self)
  end

  def last_node
    Node.new(size-1,self)
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

  def swap(node, node2)
    @data[node.index], @data[node2.index] = @data[node2.index], @data[node.index]
  end

  def add(val)
    @data << val
    heapify_up
  end

  def heapify_up
    node = last_node
    while node.parent && node.val < node.parent.val
      swap(node, node.parent)
      node = node.parent
    end
  end

  def heapify_down
    node = root
    p node.val
    while(node.left)
      smaller_node = node.left
      if node.right && node.right.val < smaller_node.val
        smaller_node = node.right
      end
      if node.val < smaller_node.val
        break
      else
        swap(node,smaller_node)
        node = smaller_node
      end
    end
  end

  def poll
    item = root.val
    swap(root, last_node)
    @data.pop
    heapify_down
    item
  end
end

heap = Heap.new([1,2,3,4,5,6,7,8,9,10])
root = heap.root
heap.add(0)
p heap.poll
