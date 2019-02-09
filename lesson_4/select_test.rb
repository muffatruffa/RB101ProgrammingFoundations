ar = %w(a f d)

new_ar = ar.select {|ch| ch << '?'}

p new_ar

p ar

p new_ar.object_id
p ar.object_i
