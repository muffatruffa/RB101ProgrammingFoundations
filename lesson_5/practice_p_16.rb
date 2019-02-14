# Each UUID consists of 32 hexadecimal characters, and is typically broken into 5 sections like this 8-4-4-4-12 and represented as a string

sections = [8, 4, 4, 4, 12]

sections.map do |char_num|
  uuid_part = ''
  char_num.times { |_| uuid_part << rand(0..15).to_s(16)}
  p uuid_part
end.join('-') # => "09b35afa-72fd-de8e-b148-62f93ef75a25"

# >> "09b35afa"
# >> "72fd"
# >> "de8e"
# >> "b148"
# >> "62f93ef75a25"
