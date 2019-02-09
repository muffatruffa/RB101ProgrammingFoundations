# How can we add multiple items to our array? (Dino and Hoppy)

flintstones = %w(Fred Barney Wilma Betty BamBam Pebbles)  # => ["Fred", "Barney", "Wilma", "Betty", "BamBam", "Pebbles"]

flintstones.concat(%w(Dino Hoppy))  # => ["Fred", "Barney", "Wilma", "Betty", "BamBam", "Pebbles", "Dino", "Hoppy"]
