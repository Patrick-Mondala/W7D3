class Integer
  # Integer#hash already implemented for you
end

class Array
  def hash
    self.map {|ele| ele.to_s(2)}.join("5").to_i.hash
  end
end

class String
  def hash
    self.split("").map {|ele| ele.unpack('b*') }.join("5").to_i.hash
  end
end

class Hash
  # This returns 0 because rspec will break if it returns nil
  # Make sure to implement an actual Hash#hash method
  def hash
    self.to_a.sort.map do |pair|
      pair.first.hash.to_s + "5" + pair.last.hash.to_s
      #128934612841234 + 5 + 897367826378216
    end.join("6").to_i.hash
    #128934612841234 + 5 + 897367826378216 + 6 + key_other_hash + 5 + value_other_hash
  end
end
