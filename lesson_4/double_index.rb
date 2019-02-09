def double_if_ind_odd(numbers)
  counter = 0
  doubled = []

  loop do
    break if counter == numbers.size

    current_number = numbers[counter]
    current_number *= 2 if counter.odd?
    doubled << current_number

    counter += 1
  end

  doubled
end


my_numbers = [1, 4, 3, 7, 2, 6]
p my_numbers
p double_if_ind_odd(my_numbers)
