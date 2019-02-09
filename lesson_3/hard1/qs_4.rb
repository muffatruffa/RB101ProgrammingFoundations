def dot_separated_ip_address_messed?(input_string)
  dot_separated_words = input_string.split(".")
  while dot_separated_words.size > 0 do
    word = dot_separated_words.pop
    break unless is_an_ip_number?(word)
  end
  return true
end

def is_an_ip_number?(num)
  num == '255' || num == '15' || num == '9'
end

def dot_separated_words?(input_string)
  dot_separated_words = input_string.split('.')
  return false if dot_separated_words.size != 4
  is_valid = true
  dot_separated_words.each do |ip|
    valid = is_an_ip_number?(ip)
    is_valid = valid if ! valid
  end
  is_valid
end

input_true = '255.15.9.15'
input_false = '255.15.9.200'
input_false_2 = '255.15.9'

p dot_separated_words?(input_true) == true
p dot_separated_words?(input_false) == false
p dot_separated_words?(input_false_2) == false

