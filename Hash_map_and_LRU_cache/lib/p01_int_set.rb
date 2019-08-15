class MaxIntSet
  attr_accessor :store
  def initialize(max)
    @store = Array.new(max, false)
  end

  def insert(num)
    raise "Out of bounds" if num > store.length - 1 || num < 0
    store[num] = true
  end

  def remove(num)
    store[num] = false
  end

  def include?(num)
    store[num]
  end

  private

  def is_valid?(num)
  end

  def validate!(num)
  end
end


class IntSet
  attr_accessor :store

  def initialize(num_buckets = 20)
    @store = Array.new(num_buckets) { Array.new }
  end

  def insert(num)
    raise "value already exists" if include?(num)
    #idx = num % num_buckets
    self[num] << num
  end

  def remove(num)
    #idx = num % num_buckets
    self[num].delete(num)
  end

  def include?(num)
     #idx = num % num_buckets
     self[num].include?(num)
  end

  private

  def [](num)
    # optional but useful; return the bucket corresponding to `num`
    idx = num % num_buckets
    store[idx]
  end

  def num_buckets
    @store.length
  end
end

class ResizingIntSet
  attr_reader :count
  attr_accessor :store

  def initialize(num_buckets = 20)
    @store = Array.new(num_buckets) { Array.new }
    @count = 0
  end

  def insert(num)
    if !include?(num)
      self[num] << num
      @count += 1
      resize! if @count == num_buckets
    end
  end

  def remove(num)
    if include?(num)
      self[num].delete(num)
      @count -= 1
    end
  end

  def include?(num)
    self[num].include?(num)
  end

  private

  def [](num)
    # optional but useful; return the bucket corresponding to `num`
    idx = num % num_buckets
    store[idx]
  end

  def num_buckets
    @store.length
  end

  def resize!
    new_int_set = ResizingIntSet.new(num_buckets * 2)
    store.each do |bucket|
      bucket.each { |ele| new_int_set.insert(ele) }
    end
    self.store = new_int_set.store
  end
end
