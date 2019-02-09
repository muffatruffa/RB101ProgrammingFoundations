# Write a one-liner to count the number of lower-case 't' characters in the following string:

statement = "The Flintstones Rock!"  # => "The Flintstones Rock!"

# statement.count('t')

statement.scan(/t/).count  # => 2
