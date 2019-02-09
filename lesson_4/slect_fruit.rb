produce = {
  'apple' => 'Fruit',
  'carrot' => 'Vegetable',
  'pear' => 'Fruit',
  'broccoli' => 'Vegetable'
}

fruits = {}

produce.each {|k, v| fruits[k] = v if v == 'Fruit'}

p fruits

# no iterator just loop

all_keys = produce.keys

loop_fruits = {}
counter = 0

loop do
  current = produce[all_keys[counter]]
  loop_fruits[all_keys[counter]] = current if current == 'Fruit'
  counter += 1
  break if counter == all_keys.size
end

p loop_fruits
