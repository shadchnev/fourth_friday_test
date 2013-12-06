require './lib/task_two'

describe Takeaway do
  let(:takeaway) { Takeaway.new ({ :Bliny => 2, :Caviar => 1 }) }
  context '#list' do
    it 'should list the available dishes + prices' do
      output = capture_stdout { Takeaway.list }
      expect(output).to eq "Bliny\t£0.45\nCaviar\t£1000.00\nKasha\t£1.00\nKnish\t£0.55\n"
    end
  end
  context '#order_total' do
    it 'should return the order total' do
      expect(takeaway.order_total).to eq Money.new(100090, "GBP")
    end
  end
  context '#place_order' do
  end

  def capture_stdout(&block)
    original_stdout = $stdout 
    $stdout = fake = StringIO.new
    begin
      yield
    ensure
      $stdout = original_stdout
    end
      fake.string
  end
end