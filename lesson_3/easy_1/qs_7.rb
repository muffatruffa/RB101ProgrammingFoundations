def add_eight(number)
    number + 8         # => 10, 18, 26, 34, 42
end                    # => :add_eight

number = 2  # => 2

how_deep = "number"                                        # => "number"
5.times { how_deep.gsub!("number", "add_eight(number)") }  # => 5

p how_deep  # => "add_eight(add_eight(add_eight(add_eight(add_eight(number)))))"

eval(how_deep)  # => 42

# >> "add_eight(add_eight(add_eight(add_eight(add_eight(number)))))"

