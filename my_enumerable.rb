# rubocop: disable Metrics/ModuleLength:
# rubocop: disable Style/For:
# rubocop: disable Style/CaseEquality:
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

  def my_all?(args = nil)
    result = true
    my_each do |item|
      if block_given?
        result = false unless yield(item)
      elsif args.nil?
        result = false unless item
      else
        result = false unless args === item
      end
    end
    result
  end

  def my_any?(args = nil)
    result = false
    my_each do |item|
      if block_given?
        result = true if yield(item)
      elsif args.nil?
        result = true if item
      elsif args === item
        result = true
      end
    end
    result
  end

  def my_none?(args = nil)
    result = true
    my_each do |item|
      if block_given?
        result = false if yield item
      elsif args.nil?
        result = false if item
      elsif args === item
        my_each { |_item| result = false }
      end
    end
    result
  end

  def my_count(args = nil)
    counter = 0
    if block_given?
      my_each do |item|
        counter += 1 if yield(item)
      end
    elsif args
      my_each do |item|
        counter += 1 if item == args
      end
    else
      my_each do
        counter += 1
      end
    end
    counter
  end

  def my_map(proc = nil)
    return to_enum(:my_map) if block_given? == false

    new_arr = []
    if proc.nil?
      my_each do |item|
        new_arr << yield(item)
      end
    end
    if block_given? && proc
      my_each do |item|
        new_arr << proc.call(item)
      end
    end
    new_arr
  end

  def my_inject(initial_arg = nil, symbol = nil)
    array = to_a
    n = array.length
    if initial_arg.nil?
      result = array[0]
      array[1..n - 1].my_each { |item| result = yield(result, item) }
    elsif block_given?
      result = initial_arg
      array.my_each { |item| result = yield(result, item) }
    elsif initial_arg && symbol
      result = initial_arg
      array.my_each { |item| result = result.send(symbol, item) }
    elsif initial_arg.is_a? Integer
      result = initial_arg
      array.my_each { |item| result += item }
    else
      result = array[0]
      array[1..n - 1].my_each { |item| result = result.send(initial_arg, item) }
    end
    result
  end
end

def multiply_els(arr)
  arr.my_inject { |product, item| product * item }
end

p multiply_els([2, 4, 5])

# rubocop: enable Metrics/ModuleLength:
# rubocop: enable Style/For:
# rubocop: enable Style/CaseEquality:
