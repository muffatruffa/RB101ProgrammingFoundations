# colors of the fruits and the sizes of the vegetables. The sizes should be uppercase and the colors should be capitalized.

# [["Red", "Green"], "MEDIUM", ["Red", "Green"], ["Orange"], "LARGE"]


hsh = {
  'grape' => {type: 'fruit', colors: ['red', 'green'], size: 'small'},
  'carrot' => {type: 'vegetable', colors: ['orange'], size: 'medium'},
  'apple' => {type: 'fruit', colors: ['red', 'green'], size: 'medium'},
  'apricot' => {type: 'fruit', colors: ['orange'], size: 'medium'},
  'marrow' => {type: 'vegetable', colors: ['green'], size: 'large'},
}


hsh.each_with_object([]) do |(k, v), arr|
  case v[:type]
  when 'fruit' then arr << v[:colors].map { |color| color.capitalize}
  when 'vegetable' then arr << v[:size].upcase
  end
end # => [["Red", "Green"], "MEDIUM", ["Red", "Green"], ["Orange"], "LARGE"]
