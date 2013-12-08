require 'money'
require 'twilio-ruby'

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
      account_sid = 'AC30311d814f432c4d8ec494076f4dd493'
      auth_token = '7f199af4c65e7bbae6b7d6d33ce922be'
      @client = Twilio::REST::Client.new account_sid, auth_token

      message = @client.account.sms.messages.create(:body => order_complete_message,
      :to => "+447526052965",
      :from => "+441633901120")
      puts message.sid
    else
      raise "The total isn't correct"
    end
  end
  def order_complete_message
    "Thank you! Your order was placed and will be delivered before #{(Time.now + 3600).strftime("%H:%M")}"
  end
end