require './my_enumerable'

describe Enumerable do
    let(:array1) { [0, 1, 2, 3, 4, 5, 6, 7, 8, 9] }
    let(:array2) { %w[microverse mark men meat ruby coding] }
    let(:array3) { [1, 2, 3, 4] }
    let(:array4) { [2, 4, 6, 8] }
    let(:array5) { [2, 4, 6, 8, 'jersey', %w[why me cr7 oa7]] }
    let(:array6) { [4, 2, 3, 4, 4, 3, 5, 4, 4] }
    let(:array7) { [1, 3, 5, 7, 9] }
    let(:array8) { [false, true] }
    let(:array9) { [true, false] }
    let(:new_array) { [] }
    let(:my_hash) { {6=>6, 8=>8} }
    let(:my_num) { [1, 2i, 3.14] }

    describe '#my_each' do
        it 'passes each item to a new array based on some operations' do
            array1.my_each { |item| new_array << item * 1 }

            expect(new_array).to eql(array1)
        end

        it 'returns a new array based on some arguments' do
            array3.my_each { |item| new_array << item * 2 }

            expect(new_array).to eql(array4)
        end

        it 'returns a new array based on some arguments' do
            array1.my_each { |item| new_array << item if item.even? && item > 0 }

            expect(new_array).to eql(array4)
        end

        it 'returns the Enumerator when no block is given' do
            expect(array1.my_each).to be_kind_of(Enumerator)
        end
    end

    describe '#my_each_with_index' do
        it 'returns element and index when argument is passed' do
            array6.my_each_with_index { |item, idx| new_array << "#{item} : #{idx}" }

            expect(new_array).to eql(["4 : 0", "2 : 1", "3 : 2", "4 : 3", "4 : 4", "3 : 5", "5 : 6", "4 : 7", "4 : 8"])
        end

        it 'returns the Enumerator when no block is given' do
            expect(array6.my_each_with_index).to be_kind_of(Enumerator)
        end

        it 'returns the index position and element when specific results are wanted' do
            hash = Hash.new
            array1.my_each_with_index {|item, index| hash[item] = index if item.even? && item > 4}
            expect(my_hash).to eql(hash)

        end
    end

    describe '#my_select' do
        it 'returns new array based on argument passed' do
            array1.my_select { |item| new_array << item if item > 0 and item % 2 == 1 }

            expect(new_array).to eql(array7)
        end

        it 'returns a specific data based on argument passed' do
            array2.my_select { |item| new_array << item if item.include? 'm' }

            expect(new_array).to eql(%w[microverse mark men meat])
        end

        it 'returns the Enumerator when no block is given' do
            expect(array1.my_select).to be_kind_of(Enumerator)
        end
    end

    describe '#my_all?' do
        it 'returns true if the length of all the words in an array is greater than 3 or equal' do
            result = array2.my_all?{ |word| word.length >= 3}
            expect(result).to be true
        end

        it 'returns false if length of all the words in an array is not greater than 4 or equal' do
            res = array2.my_all?{ |word| word.length >= 4}
            expect(res).to be false
        end

        it 'returns false if a specific alphabetic does not exist in all the words' do
            my_res = array2.my_all?(/t/)
            expect(my_res).to be false
        end

        it 'returns true if all are numeric' do
            my_result = my_num.my_all?(Numeric)
            expect(my_result).to be true
        end
    end

    describe '#my_any?' do
        it 'returns true if the length of any of the words in an array is greater than 3 or equal' do
            result = array2.my_any?{ |word| word.length >= 3}
            expect(result).to be true
        end

        it 'returns true if length of any of the words in an array is greater than 4 or equal' do
            res = array2.my_any?{ |word| word.length >= 4}
            expect(res).to be true
        end

        it 'returns true if a specific alphabetic exist in any of the words' do
            my_res = array2.my_any?(/t/)
            expect(my_res).to be true
        end

        it 'returns true if any of the items is numeric' do
            my_result = my_num.my_any?(Numeric)
            expect(my_result).to be true
        end
    end

    describe '#my_none?' do
        it 'returns true if none of the words in the array has a length equal to 2' do
            result = array2.my_none?{ |word| word.length == 2}
            expect(result).to be true
        end

        it 'returns false if any of the words in an array has a length equal to 3' do
            res = array2.my_none?{ |word| word.length == 3}
            expect(res).to be false
        end

        it 'returns false if a specific alphabetic exist in any of the words' do
            my_res = array2.my_none?(/t/)
            expect(my_res).to be false
        end

        it 'returns false if any of the items is numeric in an array' do
            my_result = my_num.my_none?(Numeric)
            expect(my_result).to be false
        end
    end

    describe '#my_count' do
        it 'returns to number of elements divisible by 2' do
            result = array1.my_count { |item| item.even? }
            expect(result).to be(5)
        end

        it 'returns the number of uppercase words' do 
            result = array2.my_count { |item| item == item.upcase }
            expect(result).to be(0)
        end

        it 'returns the number of a particular element in an array' do
            result = array6.my_count(4)
            expect(result).to be(5)
        end

        it 'returns the number of all elements in an array' do
            expect(array6.my_count).to be(9)
        end
    end

    describe '#my_map' do
        it 'returns a new array when argument is passed' do
            result = array3.my_map { |item| item * 2 }
            expect(result).to eql(array4)
        end

        it 'returns the opposite of the boleans' do
            expect(array8.my_map{ |bool| !bool }).to eql(array9)
        end
    end
end