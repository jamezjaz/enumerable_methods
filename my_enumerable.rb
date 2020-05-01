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
end

# arr = [1, 2, 3, 4]
# arr.my_each_with_index {|num| p num * 2}