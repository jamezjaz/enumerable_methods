require './my_enumerable'

describe Enumerable do
    let(:array1) { [0, 1, 2, 3, 4, 5, 6, 7, 8, 9] }
    let(:array2) { %w[hello hey hi holla yea good] }
    let(:array3) { [1, 2, 3, 4] }
    let(:array4) { [2, 4, 6, 8] }
    let(:array5) { [2, 4, 6, 8, 'jersey', %w[why me cr7 oa7]] }
    let(:array6) { [4, 2, 3, 4, 4, 3, 5, 4, 4] }
    let(:new_array) { [] }

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
            # array1.my_each { |item| new_array.push(item) if item.even? && item > 0 }
            array1.my_each { |item| new_array << item if item.even? && item > 0 }

            expect(new_array).to eql(array4)
        end

        it 'returns the Enumerator when no block is given' do
            expect(array1.my_each).to be_kind_of(Enumerator)
        end
    end

end