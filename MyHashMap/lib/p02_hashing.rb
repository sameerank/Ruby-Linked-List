class Fixnum
  # Fixnum#hash already implemented for you
end

class Array
  def hash
    final_hash = 0
    self.each_with_index do |el, index|
      final_hash += el.hash * (index + 1)
    end
    final_hash
  end
end

class String
  def hash
    string_arr = self.split("")
    final_hash = 0
    string_arr.each_with_index do |el, index|
      final_hash += el.ord.hash * (index + 1)
    end
    final_hash

  end
end

class Hash
  def hash
    keys_ary = self.keys
    final_hash = 0
    keys_ary.each do |el|
      final_hash += el.hash
    end
    final_hash
  end
end
