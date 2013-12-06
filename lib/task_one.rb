class Array
  def injection(*args)
    if args.size == 1 && !block_given?
      result = self.first
      my_proc = proc { |result, element| result = result.send(args.first, element) }
      self.each_with_index do |element, index|
        next if index == 0
        result = my_proc.call(result, element)
      end
      result
    elsif args.size == 2
      result = args.first
      my_proc = proc { |result, element| result = result.send(args.last, element) }
      self.each_with_index do |element, index|
        result = my_proc.call(result, element)
      end
      result
    else
      result = args.first || self.first
      self.each_with_index do |element, index|
        next if args.empty? && index == 0
        result = yield(result, element)
      end
      result
    end
  end
end