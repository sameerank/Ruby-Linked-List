class MaxIntSet
  def initialize(max)
    @store = Array.new(max, false)
    @max = max
  end

  def insert(num)
    validate!(num)
    @store[num] = true
  end

  def remove(num)
    validate!(num)
    @store[num] = false
  end

  def include?(num)
    validate!(num)
    @store[num]
  end

  private

  def is_valid?(num)
    num.between?(0,@max)
  end

  def validate!(num)
    raise "Out of bounds" unless is_valid?(num)
  end
end


class IntSet
  def initialize(num_buckets = 20)
    @store = Array.new(num_buckets) { Array.new }
    @num_buckets = num_buckets
  end

  def insert(num)
    @store[num % @num_buckets] << num unless include?(num)
  end

  def remove(num)
    @store[num % @num_buckets].delete(num) if include?(num)

  end

  def include?(num)
    @store[num % @num_buckets].include?(num)
  end

  private

  def [](num)
    # optional but useful; return the bucket corresponding to `num`
  end

  def num_buckets
    @store.length
  end
end

class ResizingIntSet
  attr_reader :count, :store

  def initialize(num_buckets = 20)
    @store = Array.new(num_buckets) { Array.new }
    @num_buckets = num_buckets
    @count = 0
  end

  def insert(num)

    @count += 1 unless include?(num)
    resize! if num_buckets < @count
    @store[num % @num_buckets] << num unless include?(num)

  end

  def remove(num)
    @count -= 1 if include?(num)
    @store[num % @num_buckets].delete(num) if include?(num)
  end

  def include?(num)
    @store[num % @num_buckets].include?(num)
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
    resizedIntSet = ResizingIntSet.new(@num_buckets)
    @store.flatten.each do |el|
      resizedIntSet.insert(el)
    end
    @store = resizedIntSet.store

  end
end
