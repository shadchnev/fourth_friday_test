class Array
  def injection(*args)
    if block_given?
      result = args.first || self.first
      self.each_with_index do |element, index|
        next if args.empty? && index == 0
        result = yield(result, element)
      end
      result
    else
      result = args.size == 1 ? self.first : args.first
      my_proc = proc { |result, element| result = result.send(args.last, element) }
      self.each_with_index do |element, index|
        next if index == 0 && args.size == 1
        result = my_proc.call(result, element)
      end
      result
    end
  end
end