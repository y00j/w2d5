class Fixnum
  # Fixnum#hash already implemented for you
end

class Array
  def hash
    number = (self.join + self.length.to_s).to_i
    number.hash
  end
end

class String
  def hash
    number = ""
    self.each_char { |char| number += char.ord.to_s }
    number.to_i.hash
  end
end

class Hash
  # This returns 0 because rspec will break if it returns nil
  # Make sure to implement an actual Hash#hash method
  def hash
    number = ""
    sorted_hash = self.sort
    sorted_hash.each { |arr| number += (arr[0].to_s + arr[1].to_s) }
    number.hash
  end
end
