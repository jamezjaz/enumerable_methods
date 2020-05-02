module Enumerable
    def my_each
        for item in self do
            yield(item)
        end
    end

    def my_each_with_index
        i = 0
        for item in self do
            yield(item, i)
            i += 1
        end 
    end

    def my_select
        new_arr = []
        for item in self do 
          new_arr.push(item) if yield(item)
        end  
        new_arr
    end

    def my_all?
        result = true
        for item in self do
          return false if yield(item) == false
        end 
        result
    end

    def my_any?
        for item in self do
          return true if yield(item)
        end 
        return false
    end

    def my_none?
        for item in self do
          return false if yield(item)
        end 
        return true
    end

    def my_count
        counter = 0
        for item in self
          if yield(item)
            counter += 1
          end
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
end

# Test cases for my_map_with_proc_or_block
# arr = [2, 3, 6, 80, 27, 10]
# p arr.my_map_with_proc_or_block { |sum, item| sum % 3 == 0 }
# Should return [true, true, true, true, false, false, false, false]