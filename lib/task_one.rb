class Array
  def injection(*args, &block)
    result = args.first || self.first
    self.each_with_index do |element, index|
      next if args.empty? && index == 0
      result = yield(result, element)
    end
    result
  end
end