# write a one-line program that creates the following output 10 times

str = "The Flintstones Rock!"

# 10.times { |number| puts (" " * number) + "The Flintstones Rock!" }

10.times { |n| puts str.rjust(str.size + n, ' ') }

