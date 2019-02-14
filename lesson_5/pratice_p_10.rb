# use the map method to return a new array identical in structure to the original but where the value of each integer is incremented by 1

ar = [{a: 1}, {b: 2, c: 3}, {d: 4, e: 5, f: 6}]


new_ar = ar.map do |ar_el|
  ind = 0
  ar_el_keys = ar_el.keys
  end_loop = ar_el_keys.size
  n_h = Hash.new
  loop do
    break if ind == end_loop
    cur_k = ar_el_keys[ind]
    cur_v = ar_el[cur_k]
    n_h[cur_k] = cur_v + 1
    ind += 1
  end
   n_h
end

[{a: 1}, {b: 2, c: 3}, {d: 4, e: 5, f: 6}].map do |hsh|
  incremented_hash = {}
  hsh.each do |key, value|
    incremented_hash[key] = value + 1
  end
  incremented_hash
end


p ar
p new_ar
