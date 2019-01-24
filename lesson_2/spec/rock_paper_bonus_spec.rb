require_relative '../rock_paper_bonus'

RSpec.describe "Rock Paper game" do
  
  describe 'Validate User input' do
    context 'When user input is valid' do
    	let(:rock) { ['r', 'R', 'ro', 'RO', 'rock', 'ROCK'] }
    	let(:spock) { ['sp', 'SP', 'spo', 'SPO', 'spock', 'SPOCK'] }
    	let(:scissors) { ['s', 'S', 'sci', 'SCI', 'scissors', 'SCISSORS'] }
    	let(:lizard) { ['l', 'L', 'liz', 'LIZ', 'lizard', 'LIZARD'] }
    	let(:paper) { ['p', 'P', 'pap', 'PAP', 'paper', 'PAPER'] }
      
      it 'returns appropriate string' do
      	rock.each do |input|
      			expect(validate_user_input(input)).to eq("rock")	
      	end
      	spock.each do |input|
      			expect(validate_user_input(input)).to eq("spock")	
      	end
      	scissors.each do |input|
      			expect(validate_user_input(input)).to eq("scissors")	
      	end
      	lizard.each do |input|
      			expect(validate_user_input(input)).to eq("lizard")	
      	end
      	paper.each do |input|
      			expect(validate_user_input(input)).to eq("paper")	
      	end      	      	
      end
    end

    context 'When user input is not valid' do
    	let(:refuse) { %w(a 12 ab CD f 0 lm sd rp pq)}
      
      it 'returns false' do 
      	refuse.each do |input|
      		expect(validate_user_input(input)).to be(false)	
      	end
      end
    end
  end

  describe 'Read user input' do 
    context 'When input valid' do 
      before do 
        allow($stdout).to receive(:write)
      end
      it 'Breaks the loop' do 
        allow_any_instance_of(Object).to receive(:validate_user_input).and_return("sp")
        expect_any_instance_of(Object).to receive(:validate_user_input).once
        read_user_choise
      end
      it 'Returns spock' do
        allow_any_instance_of(Object).to receive(:gets).and_return("sp")
        expect(read_user_choise).to eq('spock')
      end
      it 'Returns lizard' do
        allow_any_instance_of(Object).to receive(:gets).and_return("L")
        expect(read_user_choise).to eq('lizard')
      end     
    end
    
    context 'When user input is not valid' do
      before do 
        allow($stdout).to receive(:write)
      end      
      it 'continues to loop' do 
        allow_any_instance_of(Object).to receive(:validate_user_input).and_return(false, false, true)
        expect_any_instance_of(Object).to receive(:validate_user_input).exactly(3).times
        read_user_choise
      end
    end
  end

  describe 'Play a round' do 
    
    context 'When the user win' do
      # scissors cut paper covers rock crushes lizard poison spock smashes scissors
      #decapitated lizard eats paper
      # disproves spock vaporizes rock crushes scissors
      let(:win_combs) { [
       ['scissors', 'paper'],
       ['paper', 'rock'],
       ['rock', 'lizard'],
       ['lizard', 'spock'],
       ['spock', 'scissors'],
       ['scissors', 'lizard'],
       ['lizard', 'paper'],
       ['paper', 'spock'],
       ['spock', 'rock'],
       ['rock', 'scissors']
       ] }
      it 'returns :win' do
        win_combs.each do |palyer, computer|
          expect(win_lose_tie(palyer, computer)).to eq(:win)
        end

      end
    end
    
    context 'When the user lose' do
      let(:lose_combs) { [
       ['paper', 'scissors'],
       ['rock', 'paper'],
       ['lizard', 'rock'],
       ['spock', 'lizard'],
       ['scissors', 'spock'],
       ['lizard', 'scissors'],
       ['paper', 'lizard'],
       ['spock', 'paper'],
       ['rock', 'spock'],
       ['scissors', 'rock']
       ] }
      it 'returns :lose' do
        lose_combs.each do |palyer, computer|
          expect(win_lose_tie(palyer, computer)).to eq(:lose)
        end        
      end
    end

    context 'When it is a tie' do
      let(:tie_combs) { [
       ['paper', 'paper'],
       ['rock', 'rock'],
       ['lizard', 'lizard'],
       ['spock', 'spock'],
       ['scissors', 'scissors']
       ] }      
      it 'returns :tie' do
        tie_combs.each do |palyer, computer|
          expect(win_lose_tie(palyer, computer)).to eq(:tie)
        end
      end
    end
  end

  describe 'Play a round' do
    let(:game_statistics) { Hash.new(0)}
    before { allow($stdout).to receive(:write) }
    
    context 'When player win' do
      it 'update player wins statistics' do
        allow_any_instance_of(Object).to receive(:gets).and_return("L")
        allow_any_instance_of(Object).to receive(:read_computer_choise).and_return('paper')
        play_round(game_statistics)
        expect(game_statistics[:win]).to eq(1)
      end
    end
    
    context 'When palyer lose' do
      it 'update palyer losses statistics' do
        allow_any_instance_of(Object).to receive(:gets).and_return("p")
        allow_any_instance_of(Object).to receive(:read_computer_choise).and_return('lizard')
        play_round(game_statistics)
        expect(game_statistics[:lose]).to eq(1)
      end
    end
    
    context 'When it is a tie' do
      it 'update player ties statistics' do
        allow_any_instance_of(Object).to receive(:gets).and_return("sp")
        allow_any_instance_of(Object).to receive(:read_computer_choise).and_return('spock')
        play_round(game_statistics)
        expect(game_statistics[:tie]).to eq(1)        
      end
    end
  
  end

  describe 'Play a Game' do
    
    before { allow($stdout).to receive(:write) }
    let(:game_statistics) { Hash.new(0)}
    
    context 'After each round' do
      it 'keeps track of rounds have been played' do
        allow_any_instance_of(Object).to receive(:play_again?).and_return(true, false)
        allow_any_instance_of(Object).to receive(:gets).and_return("L")
        allow_any_instance_of(Object).to receive(:read_computer_choise).and_return('paper')
        play_game(game_statistics)
        expect(game_statistics[:rounds]).to eq(2)
      end
      it 'keeps track of wins' do
        allow_any_instance_of(Object).to receive(:play_again?).and_return(true, false)
        allow_any_instance_of(Object).to receive(:gets).and_return("L")
        allow_any_instance_of(Object).to receive(:read_computer_choise).and_return('paper')
        play_game(game_statistics)
        expect(game_statistics[:win]).to eq(2)
      end
      it 'keeps track of losses' do
        allow_any_instance_of(Object).to receive(:play_again?).and_return(true, false)
        allow_any_instance_of(Object).to receive(:gets).and_return("p")
        allow_any_instance_of(Object).to receive(:read_computer_choise).and_return('lizard')
        play_game(game_statistics)
        expect(game_statistics[:lose]).to eq(2)
      end
      it 'keeps track of ties' do
        allow_any_instance_of(Object).to receive(:play_again?).and_return(true, false)
        allow_any_instance_of(Object).to receive(:gets).and_return("p")
        allow_any_instance_of(Object).to receive(:read_computer_choise).and_return('paper')
        play_game(game_statistics)
        expect(game_statistics[:tie]).to eq(2)
      end

      it 'Breaks the loop if user do not enter y' do
        allow_any_instance_of(Object).to receive(:play_again?).and_return(false)
        expect_any_instance_of(Object).to receive(:play_round).once
        play_game(game_statistics)
      end

      it 'Keep playing if user enter y' do
        allow_any_instance_of(Object).to receive(:play_again?).and_return(true, true, false)
        expect_any_instance_of(Object).to receive(:play_round).exactly(3).times
        play_game(game_statistics)
      end
    end

    context 'When a player total wins reach 5 ' do
      it 'Stops the game' do
        @game_statistics = Hash.new(0)
        #@game_statistics[:win] = 5
        allow_any_instance_of(Object).to receive(:play_again?).and_return(true, true, true, true)
        allow_any_instance_of(Object).to receive(:gets).and_return("L")
        allow_any_instance_of(Object).to receive(:read_computer_choise).and_return('paper')
        #expect_any_instance_of(Object).to receive(:play_round).exactly(5).times
        play_game(@game_statistics)
        expect(@game_statistics[:win]).to eq(5)
      end
      it 'Update grand player to You' do 
        allow_any_instance_of(Object).to receive(:play_again?).and_return(true, true, true, true, false)
        allow_any_instance_of(Object).to receive(:gets).and_return("L")
        allow_any_instance_of(Object).to receive(:read_computer_choise).and_return('paper')
        play_game(game_statistics)
        expect(game_statistics[:grand]).to eq("You")
      end
      it 'Update grand player to Computer' do 
        allow_any_instance_of(Object).to receive(:play_again?).and_return(true, true, true, true, false)
        allow_any_instance_of(Object).to receive(:gets).and_return("P")
        allow_any_instance_of(Object).to receive(:read_computer_choise).and_return('lizard')
        play_game(game_statistics)
        expect(game_statistics[:grand]).to eq("Computer")
      end

    end
  
  end


end
