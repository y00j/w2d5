require 'byebug'
require_relative 'p02_hashing'

class HashSet
  attr_reader :count

  def initialize(num_buckets = 8)
    @store = Array.new(num_buckets) { Array.new }
    @count = 0
  end

  def insert(key)
    unless self.include?(key)
      resize! if @count == num_buckets
      self[key].push(key)
      @count += 1
    end
  end

  def include?(key)
    self[key].include?(key)
  end

  def remove(key)
    @count -= 1 if self.include?(key)
    self[key].delete(key)
  end

  private

  def [](num)
    # optional but useful; return the bucket corresponding to `num`
    idx = num.hash % num_buckets
    @store[idx]
  end

  def num_buckets
    @store.length
  end

  def resize!
    temp_arr = Array.new(num_buckets) { [] }
    @store.concat(temp_arr)

    @store.each do |bucket|
      bucket.each do |el|
        bucket.delete(el)
        self[el].push(el)
      end
    end

  end
end
