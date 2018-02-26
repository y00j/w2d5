class Node
  attr_accessor :key, :val, :next, :prev

  def initialize(key = nil, val = nil)
    @key = key
    @val = val
    @next = nil
    @prev = nil
  end

  def to_s
    "#{@key}: #{@val}"
  end

  def remove
    self.next.prev = self.prev
    self.prev.next = self.next
    @next = nil
    @prev = nil
    # optional but useful, connects previous link to next link
    # and removes self from list.
  end
end

class LinkedList
  include Enumerable

  def initialize
    @head = Node.new
    @tail = Node.new
    @head.next = @tail
    @tail.prev = @head
  end

  def [](i)
    each_with_index { |link, j| return link if i == j }
    nil
  end

  def first
    @head.next
  end

  def last
    @tail.prev
  end

  def empty?
    @head.next == @tail
  end

  def get(key)
    each { |node| return node.val if node.key == key }
    nil
  end

  def include?(key)

    each do |node|
      return true if node.key == key
    end
    false
  end

  def append(key, val)
    new_node = Node.new(key, val)
    new_node.prev = @tail.prev
    new_node.prev.next = new_node
    new_node.next = @tail
    @tail.prev = new_node
  end

  def update(key, val)
    each do |node|
      if node.key == key
        node.val = val
        break
      end
    end
  end

  def remove(key)
    removed_node = nil
    each { |node| removed_node = node if node.key == key }
    removed_node.remove unless removed_node.nil?
  end

  def each(&blk)
    next_link = first
    until next_link == @tail
      blk.call(next_link)
      next_link = next_link.next
    end

  end

  # uncomment when you have `each` working and `Enumerable` included
  # def to_s
  #   inject([]) { |acc, link| acc << "[#{link.key}, #{link.val}]" }.join(", ")
  # end
end
