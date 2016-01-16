class Link
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
end

class LinkedList
  include Enumerable

  def initialize
    @head = nil
    @tail = nil
  end

  def [](i)
    each_with_index { |link, j| return link if i == j }
    nil
  end

  def first
    @head

  end

  def last
    @tail
  end

  def empty?
    if @head.nil?
      return true
    else
      false
    end
  end

  def get(key)
    search_link = @head
    until search_link.nil? || search_link.key == key
      search_link = search_link.next
    end
    if search_link.nil?
      nil
    else
      search_link.val
    end
  end

  def include?(key)
    search_link = @head
    until search_link.nil? || search_link.key == key
      search_link = search_link.next
    end
    return false if search_link.nil?
    true
  end

  def insert(key, val)
    link = Link.new(key,val)

    if empty?
      @head = link
      @tail = link
    else
      link.prev = @tail
      @tail.next = link
      @tail = link
    end

  end

  def remove(key)
    search_link = @head
    until search_link.nil? || search_link.key == key
      search_link = search_link.next
    end

    if search_link.nil?
      return
    else
      if search_link.next.nil? && search_link.prev.nil?
        @head = nil
        @tail = nil
      elsif search_link.next.nil?
        search_link.prev.next = nil
        @tail = search_link.prev
      elsif search_link.prev.nil?
        search_link.next.prev = nil
        @head = search_link.next
      else
        search_link.prev.next = search_link.next
        search_link.next.prev = search_link.prev
      end
    end

    search_link.val
  end

  def each(&blk)
    search_link = @head
    until search_link.nil?
      blk.call(search_link)
      search_link = search_link.next
    end

  end

  # uncomment when you have `each` working and `Enumerable` included
  # def to_s
  #   inject([]) { |acc, link| acc << "[#{link.key}, #{link.val}]" }.join(", ")
  # end
end
