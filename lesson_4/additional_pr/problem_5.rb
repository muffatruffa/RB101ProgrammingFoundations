# Find the index of the first name that starts with "Be"

flintstones = %w(Fred Barney Wilma Betty BamBam Pebbles)

index = nil

flintstones.each_with_index { |val, ind| index = ind if val.start_with?('Be') }

p index
