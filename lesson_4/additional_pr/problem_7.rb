# Create a hash that expresses the frequency with which each letter occurs in this string:

statement = "The Flintstones Rock"

char_frequency = Hash.new(0)

statement.each_char { |char| char_frequency[char] += 1 unless char == ' ' }

p char_frequency
