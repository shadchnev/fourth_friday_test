require 'money'

class Takeaway
  MENU = { :Bliny => Money.new(45, "GBP"), :Caviar => Money.new(100_000, "GBP"), :Kasha => Money.new(100, "GBP"), :Knish => Money.new(55, "GBP")}
  def self.list
    MENU.each do |dish, price|
      puts "#{dish}\t£#{price}"
    end
  end
  # def initialize(options = {})
  #   defaults = { :Bliny =>}
end