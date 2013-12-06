class Takeaway
  MENU = { :Bliny => "£0.45", :Caviar => "£1000.00", :Kasha => "£1.00", :Knish => "£0.55" }
  def self.list
    MENU.each do |dish, price|
      puts "#{dish}\t#{price}"
    end
  end
end