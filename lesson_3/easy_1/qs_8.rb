flintstones = ["Fred", "Wilma"]       # => ["Fred", "Wilma"]
flintstones << ["Barney", "Betty"]    # => ["Fred", "Wilma", ["Barney", "Betty"]]
flintstones << ["BamBam", "Pebbles"]  # => ["Fred", "Wilma", ["Barney", "Betty"], ["BamBam", "Pebbles"]]

flintstones.flatten!  # => ["Fred", "Wilma", "Barney", "Betty", "BamBam", "Pebbles"]

flintstones  # => ["Fred", "Wilma", "Barney", "Betty", "BamBam", "Pebbles"]
