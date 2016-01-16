require_relative 'p02_hashing'
require_relative 'p04_linked_list'

class HashMap
  attr_reader :count, :store
  include Enumerable

  def initialize(num_buckets = 8)
    @store = Array.new(num_buckets) { LinkedList.new }
    @count = 0
    @num_buckets = num_buckets

  end

  def include?(key)
    num = key.hash
    @store[num % @num_buckets].include?(key)
  end

  def set(key, val)
    num = key.hash
    @count += 1 unless include?(key)
    resize! if @num_buckets < @count
    if include?(key)
      delete(key)
    end
    @store[num % @num_buckets].insert(key,val)
  end

  def get(key)
    num = key.hash
    if @store[num % @num_buckets].include?(key)
      return @store[num % @num_buckets].get(key)
    else
      return nil
    end
  end

  def delete(key)
    num = key.hash
    @count -= 1 if include?(key)
    @store[num % @num_buckets].remove(key) if include?(key)

  end

  def each(&prc)
    @store.each do |list|
      list.each do |link|
        prc.call(link.key, link.val)
      end
    end
  end

  # uncomment when you have Enumerable included
  # def to_s
  #   pairs = inject([]) do |strs, (k, v)|
  #     strs << "#{k.to_s} => #{v.to_s}"
  #   end
  #   "{\n" + pairs.join(",\n") + "\n}"
  # end

  alias_method :[], :get
  alias_method :[]=, :set

  private

  def num_buckets
    @store.length
  end

  def resize!
    @num_buckets = @num_buckets * 2 
    hash_map = HashMap.new(@num_buckets)
    @store.each do |list|
      list.each do |link|
        hash_map[link.key] = link.val
      end
    end
    @store = hash_map.store

  end

  def bucket(key)
    # optional but useful; return the bucket corresponding to `key`
  end
end
