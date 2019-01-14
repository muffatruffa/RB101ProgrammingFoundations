require './user_cml'

loan_calc = lambda do |array|
  loan_amount = array[0]
  mounthly_rate = array[1]
  n_mounths = array[2]
  mounthly_payment = loan_amount * (
    mounthly_rate / (
    1 - (1 + mounthly_rate)**-n_mounths))
  mounthly_payment.round(2)
end

@validator = lambda do |n|
  # copied and trasformed from ruby documentation examples
  float_pat = %r{\A
  %?\s*
  ([[:digit:]]+ # 1 or more digits before the decimal point
  (\.          # Decimal point
  [[:digit:]]+ # 1 or more digits after the decimal point
  )?) # The decimal point and following digits are optional
  \s*%?
  \Z}x
  float_pat.match(n)
end

sanitize_amount = ->(n) { n.to_f.round(2) }
sanitize_rate = ->(n) { (n.to_f != 0.0) && (n.to_f / 100) / 12 }
sanitize_duration = ->(n) { (n.to_f * 12).to_i }

loop do
  # will store in order: loan amount, rate, duration
  @input_ar = Array.new(3)

  print_message(MESSAGES["ms_loan"])
  @input_to_data = sanitize_amount
  ask_user_input("er_valid_amount") { |amount, input_ar| input_ar[0] = amount }

  print_message(MESSAGES["ms_rate"])
  @input_to_data = sanitize_rate
  ask_user_input("er_valid_rate") { |rate, input_ar| input_ar[1] = rate }

  print_message(MESSAGES["ms_duration"])
  @input_to_data = sanitize_duration
  ask_user_input("er_valid_years") { |years, input_ar| input_ar[2] = years }

  result = work_input(@input_ar, &loan_calc)

  print_message("#{MESSAGES['ms_result']}: #{result}")
  print_message(MESSAGES["ms_end"])

  carry_on = gets.chomp
  break unless /y/i =~ carry_on
end
