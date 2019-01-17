
require 'yaml'
MESSAGES = YAML.load_file('loan_messages.yml')

# provided an array as input data and a block work out the result
def work_out_input(array)
  loan_amount = array[0]
  mounthly_rate = array[1]
  n_mounths = array[2]
  mounthly_payment = loan_amount * (
    mounthly_rate / (
    1 - (1 + mounthly_rate)**-n_mounths))
  mounthly_payment.round(2)
end

def read_rate()
  print_message(MESSAGES['ms_rate'])
  loop do
    user_input = gets.chomp.strip
    rate = validate(user_input)
    return (rate.to_f / 100) / 12 if rate
    print_error(user_input, "er_valid_rate")
  end
end

def read_amount
  print_message(MESSAGES["ms_loan"])
  loop do
    user_input = gets.chomp.strip
    amount = validate(user_input)
    return amount.to_f.round(2) if amount
    print_error(user_input, "er_valid_amount")
  end
end


def read_duration
  print_message(MESSAGES['ms_duration'])
  loop do
    user_input = gets.chomp.strip
    duration = validate(user_input)
    return (duration.to_f * 12).to_i if duration
    print_error(user_input, "er_valid_years")
  end
end

def print_message(msg)
  puts "=> #{msg}"
end

def print_error(user_input, msg_key)
  puts "#{MESSAGES[msg_key]}, #{user_input} is not valid."
end

def validate(user_input)
  float_pat = %r{\A
  %?\s*
  ([[:digit:]]+ # 1 or more digits before the decimal point
  (\.          # Decimal point
  [[:digit:]]+ # 1 or more digits after the decimal point
  )?) # The decimal point and following digits are optional
  \s*%?
  \Z}x
  matched = float_pat.match(user_input) 
  matched && matched[1].to_f != 0.0 && matched[1]
end

print_message(MESSAGES['ms_welcome'])
puts
loop do
  # will store in order: loan amount, rate, duration
  input_ar = Array.new(3)

  input_ar[0] = read_amount

  input_ar[1] = read_rate

  input_ar[2] = read_duration

  result = work_out_input(input_ar)

  #print_message("#{MESSAGES['ms_result']}: #{result}")
  printf("%-25s $%-8.2f\n", "Amount", input_ar[0])
  printf("%-25s %%%-8.2f\n", "Annual Rate", (input_ar[1]*100)*12)
  printf("%-25s %-8d\n", "Duration in mounths", input_ar[2])
  printf("%-25s $%-8.2f\n", MESSAGES['ms_result'], result)
  print_message(MESSAGES["ms_end"])

  carry_on = gets.chomp
  break unless /y/i =~ carry_on
end
