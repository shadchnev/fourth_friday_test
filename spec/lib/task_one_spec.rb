require './lib/task_one'

describe Array do
  context '#injection' do
    let(:array) { [1, 2, 3, 4] }
    let(:array_two) { [1, 2, 3, 4, 5] }
    it 'should be able to sum the values of [1, 2, 3, 4]' do
      expect(array.injection { |sum, n| sum + n }).to eq 10
    end
    it 'should be able to sum the values of [1, 2, 3, 4, 5]' do
      expect(array_two.injection { |sum, n| sum + n }).to eq 15
    end
    it 'should be able to sum the values of [1, 2, 3, 4] when passed 0 as an argument' do
      expect(array.injection(0) { |sum, n| sum + n }).to eq 10
    end
    it 'should be able to sum the values of [1, 2, 3, 4] when passed 10 as an argument' do
      expect(array.injection(10) { |sum ,n| sum + n } ).to eq 20
    end
    it 'should be able to multiply the values of [1, 2, 3, 4]' do
      expect(array.injection { |product, n| product * n} ).to eq 24
    end
    it 'should be able to multiply the values of [1, 2, 3, 4] when passed 10 as an argument' do
      expect(array.injection(10) { |product, n| product * n} ).to eq 240
    end
    it 'should be able to multiply the values of [3, 4, 5] when passed 3 as an argument' do
      expect([3, 4, 5].injection(3) { |product, n| product * n} ).to eq 180
    end
    it 'should be able to return the longest word' do
      expect(%w[one two three four].injection do |longest, word|
        longest.length > word.length ? longest : word
      end).to eq "three"
    end
    it 'should be able to sum the numbers from 1 to 4 with just :+ as an argument' do
      expect(array.injection(:+)).to eq 10
    end
  end
end