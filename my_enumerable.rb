module Enumerable
    def my_each
        for item in self do
            yield(item)
        end
    end
end

# arr = [1, 2, 3, 4]
# arr.my_each {|num| p num * 2}