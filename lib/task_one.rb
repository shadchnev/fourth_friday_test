class Array
  def injection(*args, &block)
    initial_given = args.size == 2 || (args.size == 1 && block_given?)
    result = initial_given ? args.first : self.first
    my_proc = block || proc { |result, element| result = result.send(args.last, element) }
    self.each_with_index do |element, index|
      next if index == 0 && !initial_given
      result = my_proc.call(result, element)
    end
    result
  end
end