VALID_CHOISES = %w(rock paper scissors spock lizard).freeze
WIN_COMBS = [
  %w(scissors paper),
  %w(paper rock),
  %w(rock lizard),
  %w(lizard spock),
  %w(spock scissors),
  %w(scissors lizard),
  %w(lizard paper),
  %w(paper spock),
  %w(spock rock),
  %w(rock scissors)
].freeze

THRESHOLD = 5

game_statistics = Hash.new(0)

def validate_user_input(user_input)
  case user_input
  when /\Ar[ock]*\Z/i then VALID_CHOISES[0]
  when /\Ap[aper]*\Z/i then VALID_CHOISES[1]
  when /\Asp[ock]*\Z/i then VALID_CHOISES[3]
  when /\As[cissors]*\Z/i then VALID_CHOISES[2]
  when /\Al[izard]*\Z/i then VALID_CHOISES[4]
  else false
  end
end

def read_user_choise
  loop do
    prompt("Choose one: #{VALID_CHOISES.join(', ')}")
    choise = validate_user_input(gets.chomp.strip)
    return choise if choise
    prompt("that's not a valid choice'")
  end
end

def read_computer_choise
  VALID_CHOISES.sample
end

def win_lose_tie(user_choise, computer_choise)
  if WIN_COMBS.include?([user_choise, computer_choise])
    :win
  elsif user_choise == computer_choise
    :tie
  else
    :lose
  end
end

def play_round(game_statistics)
  user_choise = read_user_choise
  computer_choise = read_computer_choise
  round_result = win_lose_tie(user_choise, computer_choise)
  display_result(round_result, user_choise, computer_choise)
  game_statistics[:grand] = round_result == :win ? 'You' : 'Computer'
  game_statistics[round_result] += 1
  game_statistics[:rounds] += 1
end

def play_game(game_statistics)
  loop do
    play_round(game_statistics)
    break if grand_winner?(game_statistics)
    prompt('Do you want play another round?')
    break unless play_again?
  end
  display_grand_winner(game_statistics)
  prompt('Thank you for playing')
end

def play_again?
  answer = gets.chomp
  answer.downcase.start_with?('y')
end

def prompt(message)
  puts "=> #{message}"
end

def display_result(win_lose_tie, user_choise, computer_choise)
  display_comupter = "Computer palyed: #{computer_choise}"
  display_user = "You palyed: #{user_choise}"
  messages = {
    win: "#{display_user}\n=> #{display_comupter}\n=> You won!",
    lose: "#{display_user}\n=> #{display_comupter}\n=> Computer won!",
    tie: "#{display_user}\n=> #{display_comupter}\n=> It's a tie!"
  }
  prompt(messages[win_lose_tie])
end

def display_grand_winner(statistics)
  n_wins = [statistics[:win], statistics[:lose]].max
  winner = statistics[:grand]
  return unless THRESHOLD == n_wins
  puts
  prompt("#{winner} won #{n_wins} times.")
  prompt("We have a grand winner: #{winner}!")
end

def grand_winner?(game_statistics)
  THRESHOLD == game_statistics[:win] || THRESHOLD == game_statistics[:lose]
end

prompt('Welcome in Rock Paper Scissors Spock Lizard!')
prompt('This are the rules:')
prompt("scissors cut paper covers rock crushes
   lizard poison spock smashes scissors
   decapitated lizard eats paper disproves
   spock vaporizes rock crushes scissors")
prompt("You can chose one of: #{VALID_CHOISES.join(', ')}")
prompt('You can type the entire word or use a shortened.')
prompt('For example: l or L or liz or lizard.')
prompt('Be aware s stands for scissors
   sp or SP or spock stand for... spock obviously.')

play_game(game_statistics)
