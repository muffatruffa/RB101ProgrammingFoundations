require 'yaml'
MESSAGES = YAML.load_file('loan_messages.yml')

@user_input = ''
@input_ar = nil
@input_to_data = nil
@validator = nil

# provided an array as input data and a block work out the result
def work_input(input_arr)
  yield(input_arr)
end

# Compose validation and input trasformation
# validator has to mimic Regex#match
def valid_sanitize(input_to_data, validator)
  lambda do |x|
    input = validator.call(x)
    input_to_data.call(input[1]) if input
  end
end

def print_message(msg)
  puts "=> #{msg}"
end

def print_error
  puts yield(@user_input)
end

# set @user_input return a valid trasformed data or nil
def prompt_user(input_to_data, validator)
  @user_input = gets.chomp.strip
  valid_sanitize(input_to_data, validator).call(@user_input)
end

# precondition: set instance variables @input_to_data and @validator
# will change @input_ar
def ask_user_input(msg_key)
  loop do
    result = prompt_user(@input_to_data, @validator)
    yield(result, @input_ar)
    break if result
    print_error do |usr_in|
      "#{MESSAGES[msg_key]}, #{usr_in} is not valid."
    end
  end
end
