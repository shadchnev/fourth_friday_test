require './lib/task_one'

describe Array do
  context '#injection' do
    let(:array) { [1, 2, 3, 4] }
    it 'should be able to sum the values of the array' do
      expect(array.injection { |sum, n| sum + n }).to eq 10
    end
  end
end