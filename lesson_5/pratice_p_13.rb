# new array containing the same sub-arrays as the original but ordered logically according to the numeric value of the odd integers they contain

# arr = [[1, 6, 7], [1, 4, 9], [1, 8, 3]] [[1, 8, 3], [1, 6, 7], [1, 4, 9]]

arr = [[1, 6, 7], [1, 4, 9], [1, 8, 3]]

arr.sort_by do |ar_el|
  ar_el.select { |num| num.odd?}
end # => [[1, 8, 3], [1, 6, 7], [1, 4, 9]]
