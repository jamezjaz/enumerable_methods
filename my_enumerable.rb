# rubocop: disable Metrics/PerceivedComplexity: Perceived complexity for my_any? is too high. [11/7]
# rubocop: disable Metrics/CyclomaticComplexity: Cyclomatic complexity for my_any? is too high. [10/6]
module Enumerable
  def my_each
    for item in self do
      yield(item)
    end
  end

  # def my_each_with_index
  #   i = 0
  #   for item in self do
  #     yield(item, i)
  #     i += 1
  #   end
  # end

  # def my_select
  #   new_arr = []
  #   for item in self do
  #     new_arr.push(item) if yield(item)
  #   end
  #   new_arr
  # end

  # def my_all?(*args)
  #   if args.nil?
  #     my_each do |item|
  #       return false unless args == item
  #     end
  #   elsif block_given?
  #     my_each do |item|
  #       return false unless yield(item)
  #     end
  #   else
  #     my_each do |item|
  #       return false unless item
  #     end
  #   end
  #   true
  # end

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

  # def my_count
  #   counter = 0
  #   for item in self
  #     counter += 1 if yield(item)
  #   end
  #   counter
  # end

  # def my_map
  #   new_arr = []
  #   for item in self do
  #     new_arr << yield(item)
  #   end
  #   new_arr
  # end

  # def my_map_with_proc
  #   new_arr = []
  #   for item in self do
  #     new_arr << proc.call(item)
  #   end
  #   new_arr
  # end

  # def my_map_with_proc_or_block
  #   new_arr = []
  #   for item in self
  #     new_arr << proc.call(item) || yield(item)
  #   end
  #   new_arr
  # end

  # def my_inject
  #   sum = self[0]
  #   for item in self do
  #     sum = yield(sum, item)
  #   end
  #   sum
  # end
end

# Test cases for my_any?
true_array = [nil, false, true, []]
true_array.my_any? == true_array.any? # true

words = %w[dog door rod blade]
words.my_any?(Integer) == words.any?(Integer) # true

words.my_any?(/z/) == words.any?(/z/) # true

words.my_any?('cat') == words.any?('cat') # true

# Test cases for my_none?
# array = Array.new(100) { rand(0...9) }
# array.my_none?(String) == true #true

# words = %w[dog door rod blade]
# words.my_none?(5) == words.none?(5) #true

#  words.my_none?(/z/) == words.none?(/z/) #true
#  words.my_none?(/f/) == words.none?(/f/) #true

# def multiply_els(arr)
#   arr.my_inject { |product, item| product * item }
# end

# p multiply_els([2, 4, 5])

# rubocop: enable Metrics/PerceivedComplexity: Perceived complexity for my_any? is too high. [11/7]
# rubocop: enable Metrics/CyclomaticComplexity: Cyclomatic complexity for my_any? is too high. [10/6]
