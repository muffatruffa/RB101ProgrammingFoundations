famous_words = "seven years ago..."  # => "seven years ago..."
begin_of_str = "Four score and"      # => "Four score and"

concat = format("%s %s", begin_of_str, famous_words)  # => "Four score and seven years ago..."
concat_b = "#{begin_of_str} #{famous_words}"          # => "Four score and seven years ago..."
