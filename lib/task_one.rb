class Array
  def injection
    sum = 0
    self.each do |element|
      sum += element
    end
    sum
  end
end