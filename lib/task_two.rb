require 'money'

class Takeaway
  MENU = { :Bliny => Money.new(45, "GBP"), :Caviar => Money.new(100_000, "GBP"), :Kasha => Money.new(100, "GBP"), :Knish => Money.new(55, "GBP")}
  def self.list
    MENU.each do |dish, price|
      puts "#{dish}\t£#{price}"
    end
  end

  attr_accessor :options
  def initialize(options = {})
    defaults = { :Bliny => 0, :Caviar => 0, :Kasha => 0, :Knish => 0}
    @options = defaults.merge(options)
  end
  def order_total
    total = Money.new(0, "GBP")
    options.each do |dish, quantity|
      total += MENU[dish] * quantity
    end
    total
  end
  def order_ok? (total)
    order_total == Money.new(total * 100, "GBP")
  end
  def place_order (total)
    if order_ok? (total)
    else
      raise "The total isn't correct"
    end
  end
end