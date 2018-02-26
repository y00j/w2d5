require 'byebug'

class MaxIntSet
  def initialize(max)
    @store = Array.new(max) { false }
  end

  def insert(num)
    raise "Out of bounds" unless is_valid?(num)
    @store[num] = true
  end

  def remove(num)
    @store[num] = false
  end

  def include?(num)
    @store[num]
  end

  private

  def is_valid?(num)
    (0...@store.length).include?(num)
  end

  def validate!(num)
  end
end


class IntSet
  def initialize(num_buckets = 20)
    @store = Array.new(num_buckets) { Array.new }
  end
  def insert(num)
    self[num].push(num)
  end

  def remove(num)
    self[num].delete(num)
  end

  def include?(num)
    self[num].include?(num)
  end

  private

  def [](num)
    idx = num % num_buckets
    @store[idx]
    # optional but useful; return the bucket corresponding to `num`
  end

  def num_buckets
    @store.length
  end

end

class ResizingIntSet
  attr_reader :count

  def initialize(num_buckets = 20)
    @store = Array.new(num_buckets) { Array.new }
    @count = 0
  end

  def insert(num)
    unless self.include?(num)
      resize! if @count == @store.length
      self[num].push(num)
      @count += 1
    end
  end

  def remove(num)
    @count -= 1 if self.include?(num)
    self[num].delete(num)
  end

  def include?(num)
    self[num].include?(num)
  end

  private

  def [](num)
    idx = num % num_buckets
    @store[idx]
  end

  def num_buckets
    @store.length
  end

  def resize!
    # if @count > num_buckets
      temp_store = Array.new(num_buckets) { Array.new }
      @store.concat(temp_store)

      @store.each do |bucket|
        bucket.each do |el|
          bucket.delete(el)
          self[el].push(el)
        end
      end
    # end
  end

end
