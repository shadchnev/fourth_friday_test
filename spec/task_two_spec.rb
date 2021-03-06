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
  context '#order_ok?' do
    it 'should return true if the order is OK' do
      expect(takeaway.order_ok?(1000.9)).to be_true
    end
    it 'should return false if the order is not ok' do
      expect(takeaway.order_ok?(1000)).to be_false
    end
  end
  context '#place_order' do
    it 'should raise an error if order is not correct' do
      expect { takeaway.place_order(1000) }.to raise_error RuntimeError
    end
    it 'should validate and send a success message when placing an order' do
      takeaway.stub(:order_ok?) { true }
      takeaway.stub(:order_complete_message) {"success"}
      takeaway.should_receive(:order_ok?)
      takeaway.should_receive(:order_complete_message)
      takeaway.place_order("xxx")
    end
  end
  context '#order_complete_message' do
    it 'should return the correct message for an order' do
      expect(takeaway.order_complete_message()).to eq "Thank you! Your order was placed and will be delivered before #{(Time.now + 3600).strftime("%H:%M")}"
    end
  end

  # Cool!
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