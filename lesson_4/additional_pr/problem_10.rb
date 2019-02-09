# Modify the hash such that each member of the Munster family has an additional "age_group" key
# kid is in the age range 0 - 17, an adult is in the range 18 - 64 and a senior is aged 65+



munsters = {
  "Herman" => { "age" => 32, "gender" => "male" },
  "Lily" => { "age" => 30, "gender" => "female" },
  "Grandpa" => { "age" => 402, "gender" => "male" },
  "Eddie" => { "age" => 10, "gender" => "male" },
  "Marilyn" => { "age" => 23, "gender" => "female"}
}


munsters =  (munsters.map do | k, v|
  group = case v['age']
          when 0..17 then 'kid'
          when 18..64 then 'adult'
          else 'senior'
          end
  new_k_v =  { 'age_group' => group }
  [k, v.merge(new_k_v)]
end).to_h


munsters.each do |name, details|
  case details["age"]
  when 0...18
    details["age_group"] = "kid"
  when 18...65
    details["age_group"] = "adult"
  else
    details["age_group"] = "senior"
  end
end



p munsters

