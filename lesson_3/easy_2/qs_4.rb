advice = "Few things in life are as important as house training your pet dinosaur."

advice_xample = "Few Dinosaurs are pretty"

advice.match("Dino") # => nil

advice_xample.match("Dino") # => #<MatchData "Dino">

# matching with a regular expression
reg = /\bDino\b/

advice_xample.match(reg) # => nil

advice_xample_Dino = "Few Dinosaurs are pretty but my Dino is"

advice_xample_Dino.match(reg) # => #<MatchData "Dino">
