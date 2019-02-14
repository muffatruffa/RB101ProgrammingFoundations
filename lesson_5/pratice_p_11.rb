# return a new array identical in structure to the original but containing only the integers that are multiples of 3

arr = [[2], [3, 5, 7], [9], [11, 13, 15]]

arr.map do |ar|
  ar.select { |num| num % 3 == 0}
end # => [[], [3], [9], [15]]
