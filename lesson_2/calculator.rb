require 'yaml'
MESSAGES = YAML.load_file('messages.yml')
LANGUAGE = 'en'
# ask the user for two number
# ask the user for an operation
# perform the operation on the two numbrs
# output the result

def messages(msg, lang = 'en')
  MESSAGES[lang][msg]
end

# add => at message
def prompt(msg_key)
  message = messages(msg_key, LANGUAGE) || msg_key
  puts "=> #{message}"
end

def old_valid_number?(num)
  num.to_i != 0
end

def valid_number?(num)
  float_pat = /\A
    [[:digit:]]+ # 1 or more digits before the decimal point
    (\.          # Decimal point
    [[:digit:]]+ # 1 or more digits after the decimal point
    )? # The decimal point and following digits are optional
  \Z/x
  float_pat.match(num)
end

def operation_to_message(operation)
  case operation
  when '1'
    'Adding'
  when '2'
    'Subtracting'
  when '3'
    'Multiplying'
  when '4'
    'Dividing'
  end
end
prompt(MESSAGES.inspect)
prompt('yml_welcome')

name = ''
loop do
  name = gets.chomp
  if name.empty?
    prompt('yml_valid_name')
  else
    break
  end
end

prompt("Hi #{name}!")

loop do # main loop
  number1 = ''
  loop do
    prompt("What's the first number?'")
    number1 = gets.chomp
    if valid_number?(number1)
      break
    else
      prompt("Hmm...#{number1} doesn't look like a valid number")
    end
  end

  number2 = ''
  loop do
    prompt("What's the second number?'")
    number2 = gets.chomp
    if valid_number?(number2)
      break
    else
      prompt("Hmm...#{number2} doesn't look like a valid number")
    end
  end

  operator_prompt = <<-MSG
    What operation would like to perform?
    1) add
    2) subtract
    3) multiply
    4) divide
  MSG
  prompt(operator_prompt)
  operator = ''
  loop do
    operator = gets.chomp
    if %w(1 2 3 4).include?(operator)
      break
    else
      prompt('Must choose 1, 2, 3, or 4')
    end
  end

  prompt("#{operation_to_message(operator)} the two numbers...")

  result = case operator
           when '1'
             number1.to_i + number2.to_i.to_i
           when '2'
             number1.to_i - number2.to_i
           when '3'
             number1.to_i * number2.to_i
           when '4'
             number1.to_f / number2.to_f
           end

  puts "the result is #{result}"

  prompt('Do you want to perform another calculation? (Y to calculate again)')
  answer = gets.chomp
  break unless answer.downcase.start_with?('y')
end
prompt('Thank you for using the calculator. Good bye!')
