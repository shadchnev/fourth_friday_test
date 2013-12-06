class Array
  def injection(*args, &block)
    if block_given?
      result = args.first || self.first
      my_proc = block_given? ? block : proc { |result, element| result = result.send(args.last, element) }
      self.each_with_index do |element, index|
        next if index == 0 && args.size == 0
        result = my_proc.call(result, element)
      end
      result
    else
      result = args.size == 1 ? self.first : args.first
      my_proc = block_given? ? block : proc { |result, element| result = result.send(args.last, element) }
      self.each_with_index do |element, index|
        next if index == 0 && args.size == 1
        result = my_proc.call(result, element)
      end
      result
    end
  end
end