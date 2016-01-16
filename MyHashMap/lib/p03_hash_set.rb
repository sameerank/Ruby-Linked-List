require_relative 'p02_hashing'

class HashSet
  attr_reader :count, :store

  def initialize(num_buckets = 8)
    @store = Array.new(num_buckets) { Array.new }
    @count = 0
    @num_buckets = num_buckets
  end

  def insert(key)
    num = key.hash
    @count += 1 unless include?(key)
    resize! if num_buckets < @count
    @store[num % @num_buckets] << key unless include?(key)

  end

  def include?(key)
    num = key.hash
    @store[num % @num_buckets].include?(key)
  end

  def remove(key)
    num = key.hash
    @count -= 1 if include?(key)
    @store[num % @num_buckets].delete(key) if include?(key)
  end

  private

  def [](num)
    # optional but useful; return the bucket corresponding to `num`
  end

  def num_buckets
    @store.length
  end

  def resize!
    @num_buckets += 1
    hash_set = HashSet.new(@num_buckets)
    @store.flatten.each do |el|
      hash_set.insert(el)
    end
    @store = hash_set.store
  end
end
