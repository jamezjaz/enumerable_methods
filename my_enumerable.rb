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
end

# arr = [10, 2, 40, 4, 1002]
# p arr.my_all? {|num| num % 2 == 0 }