# returns true if num in start..ending range
def is_in_range?(num, start, ending)
  (start..ending) === num             # => true
end                                   # => :is_in_range?

is_in_range?(42, 10, 100)  # => true

