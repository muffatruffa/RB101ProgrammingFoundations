advice = "Few things in life are as important as house training your pet dinosaur."  # => "Few things in life are as important as house training your pet dinosaur."

new_advice = advice.gsub(/important/, 'urgent')  # => "Few things in life are as urgent as house training your pet dinosaur."

advice  # => "Few things in life are as important as house training your pet dinosaur."

# change original string
advice.gsub!(/important/, 'urgent')  # => "Few things in life are as urgent as house training your pet dinosaur."

advice  # => "Few things in life are as urgent as house training your pet dinosaur."

# using cpatures evry swap last two letters in words if word ends with vowel 

advice.gsub(/(\b\w*)(\w)([aeiou])\b/, '\1\3\2')  # => "Few things in lief aer as urgent as houes training your pet dinosaur."
