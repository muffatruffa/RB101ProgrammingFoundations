def multiply(arr, num)
  index = 0
  result = []

  loop do
    break if index == arr.size
    current_item = arr[index]
    result[index] = current_item * num

    index += 1
  end


  result
end

my_numbers = [1, 4, 3, 7, 2, 6]
p multiply(my_numbers, 3)
