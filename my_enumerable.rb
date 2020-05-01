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
end

arr = [1, 2, 3, 4]
p arr.my_select {|num| num % 2 == 0 }