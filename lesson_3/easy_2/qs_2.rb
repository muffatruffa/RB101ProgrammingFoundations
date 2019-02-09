munsters_description = "The Munsters are creepy in a good way."

# if t and m are capital at beginning of word make theme downcase
#p munsters_description.upcase.gsub(/\b([TM])/) { |_| "#{$1.downcase}" }

p munsters_description.swapcase

# capitalize
p munsters_description.capitalize

# downcaae
p munsters_description.downcase

# upcase
p munsters_description.upcase
