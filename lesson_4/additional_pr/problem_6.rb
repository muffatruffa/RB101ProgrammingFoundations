# Amend this array so that the names are all shortened to just the first three characters:

flintstones = %w(Fred Barney Wilma Betty BamBam Pebbles)

counter = 0

loop do
  break if counter == flintstones.size

  current_val = flintstones[counter]
  flintstones[counter] = current_val[0,3]

  counter += 1
end

p flintstones
