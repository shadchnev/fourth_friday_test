require 'money'
require 'twilio-ruby'

class Takeaway
  MENU = { :Bliny => Money.new(45, "GBP"), :Caviar => Money.new(100_000, "GBP"), :Kasha => Money.new(100, "GBP"), :Knish => Money.new(55, "GBP")}
  def self.list
    # Generally, avoid printing stuff in the code
    # Return things instead. Let the code that called the method
    # print it
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
    # an extra gem for Money is a bit of an overkill but I don't mind :)
    total = Money.new(0, "GBP")
    options.each do |dish, quantity| # why not inject?
      total += MENU[dish] * quantity
    end
    total
  end
  def order_ok? (total)
    order_total == Money.new(total * 100, "GBP")
  end
  def place_order (total)
    if order_ok? (total)
      account_sid = 'AC30311d814f432c4d8ec494076f4dd493' # this should be in the env var
      auth_token = '7f199af4c65e7bbae6b7d6d33ce922be' # as well as this
      @client = Twilio::REST::Client.new account_sid, auth_token

      # The biggest problem in this code test is that you aren't stubbing
      # this call, so a text seems to be sent every time I run the test suite
      message = @client.account.sms.messages.create(:body => order_complete_message,
      :to => "+447526052965",
      :from => "+441633901120")
      puts message.sid # avoid printing stuff in the code, return it instead
    else
      raise "The total isn't correct"
    end
  end
  def order_complete_message
    "Thank you! Your order was placed and will be delivered before #{(Time.now + 3600).strftime("%H:%M")}"
  end
end