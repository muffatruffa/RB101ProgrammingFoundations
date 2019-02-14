# Using the each method, write some code to output all of the vowels from the strings.

hsh = {first: ['the', 'quick'], second: ['brown', 'fox'], third: ['jumped'], fourth: ['over', 'the', 'lazy', 'dog']}

hsh.each_value do |val|
  val.each do |word|
    word.chars.select { |char| char.match(/[aeiou]/)}.each { |vowel| puts vowel}
  end
end

hsh.inject('') do |acc, (k,v)|
  acc + v.inject('') do  |v_in_w, word|
  v_in_w + word.scan(/[aeiou]/).join
  end
end # => "euiooueoeeao"

vowels = 'aeiou'

hsh.each do |_, value|
  value.each do |str|
    str.chars.each do |char|
      puts char if vowels.include?(char)
    end
  end
end

# >> e
# >> u
# >> i
# >> o
# >> o
# >> u
# >> e
# >> o
# >> e
# >> e
# >> a
# >> o
# >> e
# >> u
# >> i
# >> o
# >> o
# >> u
# >> e
# >> o
# >> e
# >> e
# >> a
# >> o

