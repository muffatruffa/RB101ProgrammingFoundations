VALID_CHOISES = ['rock', 'paper', 'scissors']

def prompt(message)
  puts "=> #{message}"
end

def display_result(win_tie_lost, user_choise, computer_choise)
  prompt("Computer palyed: #{computer_choise}")
  prompt("You palyed: #{user_choise}")
  prompt(win_tie_lost)
end

def read_user_choise
  loop do
    prompt("Choose one: #{VALID_CHOISES.join(', ')}")

    choise = gets.chomp

    if VALID_CHOISES.include?(choise)
      return choise
    else
      prompt("that's not a valid choice'")
    end
  end
end

def read_computer_choise
  VALID_CHOISES.sample
end

def play_again?
  answer = gets.chomp
  answer.downcase.start_with?('y')
end

# Play one round of rock paper scissors
def play_r_p_s_round(user_choise, computer_choise)
  case [user_choise, computer_choise]
  # First time call we prompt the user and we call recursively play_r_p_s_round
  when [nil, nil]
    play_r_p_s_round(read_user_choise, read_computer_choise)
  # the win case
  when ['rock', 'scissors'], ['paper', 'rock'], ['scissors', 'paper']
    display_result("You won!", user_choise, computer_choise)
  # tie or lost case
  else
    # a tie
    if user_choise == computer_choise
      display_result("It's a tie!", user_choise, computer_choise)
    # computer won
    else
      display_result("Computer won!", user_choise, computer_choise)
    end
  end
end

# Play several rounds of rock paper scissors
def play_r_p_s_game(ask_for_round)
  case ask_for_round
  # First time call or called to play again
  when nil
    play_r_p_s_round(nil, nil)
    play_r_p_s_game(true)
  # After a round we ask for another one
  when true
    prompt("Do you want play another round?")
    if play_again?
      play_r_p_s_game(nil)
    else
      prompt("Thank yoy for playing")
    end
  end
end
play_r_p_s_game(nil)
