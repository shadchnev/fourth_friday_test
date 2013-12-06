class Array
  def injection(*args)
    sum = 0
    self.each do |element|
      sum += element
    end
    sum + (args.empty? ? 0 : args.first)
  end
end