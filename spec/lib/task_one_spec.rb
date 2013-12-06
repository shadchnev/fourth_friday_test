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
  end
end