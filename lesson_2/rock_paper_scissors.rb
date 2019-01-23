VALID_CHOISES = ['rock', 'paper', 'scissors']

def prompt(message)
  puts "=> #{message}"
end

def display_result(player_choise, computer_choise)
  if (player_choise == 'rock' && computer_choise == 'scissors') ||
     (player_choise == 'paper' && computer_choise == 'rock') ||
     (player_choise == 'scissors' && computer_choise == 'paper')
    prompt("You won!")
  elsif (player_choise == 'rock' && computer_choise == 'paper') ||
        (player_choise == 'paper' && computer_choise == 'scissors') ||
        (player_choise == 'scissors' && computer_choise == 'rock')
    prompt("Computer won!")
  else
    prompt("It's a tie!'")
  end
end
loop do
  choise = ''
  loop do
    prompt("Choose one: #{VALID_CHOISES.join(', ')}")
    choise = gets.chomp

    if VALID_CHOISES.include?(choise)
      break
    else
      prompt("that's not a valid choice'")
    end
  end

  computer_choise = VALID_CHOISES.sample
  display_result(choise, computer_choise)
  prompt("Do you want play another round?")
  answer = gets.chomp
  break unless answer.downcase.start_with?('y')
end
prompt("Thank yoy for playing")
