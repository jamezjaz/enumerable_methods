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
end

# arr = [1, 3, 4, 4, 10]
# p arr.my_none? {|num| num % 3 == 1 }