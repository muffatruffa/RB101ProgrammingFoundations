def titalize(a_string)
  a_string.gsub(/\b./) { |match_str| "#{match_str.capitalize}"}

end

# words.split.map { |word| word.capitalize }.join(' ')

words = "the flintstones rock"


p titalize(words)

p words
