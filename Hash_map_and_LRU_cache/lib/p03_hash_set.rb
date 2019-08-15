class HashSet
  attr_reader :count
  attr_accessor :store
  def initialize(num_buckets = 8)
    @store = Array.new(num_buckets) { Array.new }
    @count = 0
  end

  def insert(key)
    if !include?(key)
      self[key.hash] << key
      @count += 1
      resize! if count == num_buckets
    end
  end

  def include?(key)
    self[key.hash].include?(key)
  end

  def remove(key)
    if include?(key)
      self[key.hash].delete(key)
      @count -= 1
    end
  end

  private

  def [](num)
    # optional but useful; return the bucket corresponding to `num`
    idx = num % num_buckets
    @store[idx]
  end

  def num_buckets
    @store.length
  end

  def resize!
    new_hash_set = HashSet.new(num_buckets * 2)
    @store.each do |bucket|
      bucket.each { |ele| new_hash_set.insert(ele) }
    end
    self.store = new_hash_set.store
  end
end
