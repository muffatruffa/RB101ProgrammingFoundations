# return a new array of the same structure but with the sub arrays being ordered 

arr = [['b', 'c', 'a'], [2, 1, 3], ['blue', 'black', 'green']]

arr.map do |ar_el|
  ar_el.sort { |a, b| b <=> a}
end # => [["c", "b", "a"], [3, 2, 1], ["green", "blue", "black"]]
