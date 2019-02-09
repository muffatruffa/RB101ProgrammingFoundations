=begin
def factors(number)
  divisor = number
  factors = []
  begin
    factors << number / divisor if number % divisor == 0
    divisor -= 1
  end until divisor == 0
  factors
end
=end

def factors(number)
  factors = []
  number.times do |n|
    factors << number / divisor if number % divisor == 0
  end
  factors
end


