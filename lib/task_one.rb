class Array
  def injection(*args, &block)
    result = args.first || self.first
    self.each do |element|
      result = yield(result, element)
    end
    result
  end
end