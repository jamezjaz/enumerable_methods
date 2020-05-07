# rubocop: disable Metrics/PerceivedComplexity: Perceived complexity for my_any? is too high. [11/7]
# rubocop: disable Metrics/CyclomaticComplexity: Cyclomatic complexity for my_any? is too high. [10/6]
module Enumerable
  def my_each
    return to_enum(:my_each) unless block_given?

    item = 0
    array = to_a
    n = array.length
    while item < n
      yield(array[item])
      item += 1
    end
  end

  def my_each_with_index
    return to_enum(:my_each_with_index) unless block_given?

    i = 0
    for item in self do
      yield(item, i)
      i += 1
    end
  end

  def my_select
    return to_enum(:my_select) unless block_given?

    new_arr = []
    for item in self do
      new_arr.push(item) if yield(item)
    end
    new_arr
  end

  def my_all?(*args)
    if args.nil?
      my_each do |item|
        return false unless args == item
      end
    elsif block_given?
      my_each do |item|
        return false unless yield(item)
      end
    else
      my_each do |item|
        return false unless item
      end
    end
    true
  end

  def my_any?(args = nil)
    if !block_given? && args.nil?
      my_each do |item|
        return true if item
      end
    elsif args.is_a? Regexp
      my_each do |item|
        return true if args == item
      end
    elsif args.is_a? Array
      my_each do |item|
        return true if yield(item)
      end
    elsif args.is_a? Hash
      my_each do |x, y|
        return true if yield(x, y)
      end
    end
    false
  end

  def my_none?(args = nil)
    if !block_given? && args.nil?
      my_each do |item|
        return false if item
      end
    elsif args.is_a? Regexp
      my_each do |item|
        return false if item == args
      end
    elsif args.is_a? Array
      my_each do |item|
        return false if yield(item)
      end
    elsif args.is_a? Hash
      my_each do |x, y|
        return false if yield(x, y)
      end
    end
    true
  end

  def my_count
    counter = 0
    for item in self
      counter += 1 if yield(item)
    end
    counter
  end

  def my_map
    new_arr = []
    for item in self do
      new_arr << yield(item)
    end
    new_arr
  end

  def my_map_with_proc
    new_arr = []
    for item in self do
      new_arr << proc.call(item)
    end
    new_arr
  end

  def my_map_with_proc_or_block
    new_arr = []
    for item in self
      new_arr << proc.call(item) || yield(item)
    end
    new_arr
  end

  def my_inject
    sum = self[0]
    for item in self do
      sum = yield(sum, item)
    end
    sum
  end
end

def multiply_els(arr)
  arr.my_inject { |product, item| product * item }
end

p multiply_els([2, 4, 5])

# rubocop: enable Metrics/PerceivedComplexity: Perceived complexity for my_any? is too high. [11/7]
# rubocop: enable Metrics/CyclomaticComplexity: Cyclomatic complexity for my_any? is too high. [10/6]
