class Play_game

def self.new_game
    @user_input=Array.new
    @answer=Array.new(4) {rand(0..5)}
    @feedback=Array.new
    @set_code=Array.new
    @choice = ""
    @computer_guess=Array.new
    
    puts "We are going to play Mastermind!"
    puts "Would you like to choose the secret code (s) or be the code breaker? (b)"
    @choice = gets.chomp
    if @choice == "b" 
      puts "The computer has selected 4 balls and placed them in a specific order to make a code."
      puts "the secret code is #{@answer}"  
      puts @feedback.empty?
    elsif @choice == "s"
      puts "Choose 4 balls from the following: red (0), blue (1), green (2), yellow (3), purple (4), aqua (5)"
      puts "Use a space to separate your entry"
      input=Array.new
      input= gets.chomp.split(" ")
      input = input.map {|n| Integer(n)}
      @set_code = @set_code + input
    else
        puts "Please input a valid selection!"
    end

end

def self.computer_guesser
  choices = [0, 1, 2, 3, 4, 5]
  hash_choices ={}
  all_choices = choices.repeated_permutation(4).to_a
  all_choices.each {|i|
    hash_choices[i] = i}
 @computer_guess = hash_choices[[0, 0, 1, 1]]
 counter = 1
 print "The computer has made its first guess #{@computer_guess}"
 computer_feedback = self.computer_output(@set_code, @computer_guess)
 print "It received the feedback #{computer_feedback}"
 while computer_feedback.any? {|i|["0", "white"].include? i}
  if computer_feedback == ["0", "0", "0", "0"]
     hash_choices.delete_if {|key,value| key.any? {|i| @computer_guess.include? i}}
  end
  hash_choices.delete_if {|key, value| self.computer_output(key, @computer_guess).sort != computer_feedback.sort}
  hash_choices.delete_if {|key, value| key == @computer_guess}
  @computer_guess = hash_choices.keys[0]
  puts "the computer has made a new guess #{@computer_guess}"
  computer_feedback = self.computer_output(@set_code, @computer_guess)
  puts "the computer has received this feedback #{computer_feedback}"
  counter +=1
  if counter == 12
    break
  end
end
 puts "the computer has correctly guessed your code in #{counter} guesses"
end 


def self.get_input
    if @feedback.empty?
        puts "please make a guess!"
        puts "You can choose some combination of balls from the following: red (0), blue (1), green (2), yellow (3), purple (4), aqua (5) "
        puts "What do you think the code is? (separate numbers with a space)"
        input=Array.new
        input= gets.chomp.split(" ")
        input = input.map {|n| Integer(n)}
        @user_input = @user_input + input
        @user_input
    end
    choose_adventure = ""  
    while @feedback.length>0 && choose_adventure != "g"
      puts "What do you want to do next? You can review all your feedback (f), make a guess (g) or quit (q)"
    choose_adventure = gets.chomp
      if choose_adventure == "f"
        n=0
        while n < @feedback.length/4
            print @user_input [0..3]
            puts "You guessed #{@user_input[(n)..(n+3)]} and the computer gave the feedback #{@feedback[n..(n+3)]}"
            n+=1
        end
     elsif choose_adventure == "q"
        exit
     elsif choose_adventure == "g"
      puts "It's time to make a new guess based on the feedback."
      puts "You can choose some combination of balls from the following: red (0), blue (1), green (2), yellow (3), purple (4), aqua (5) "
      puts "What do you think the code is? (separate numbers with a space)"
      input=Array.new
      input= gets.chomp.split(" ")
      input = input.map {|n| Integer(n)}
      @user_input = @user_input + input
      @user_input
      else
        puts "invalid choice! Try again"
      end
end
end

def self.computer_output(answer, guess)
  tester = answer.clone
  computer = Array.new

 guess.each_with_index {|n, index|
   if n == tester[index]
     tester[index]=9
     computer.push("black")
   end
 }
 guess.each {|n|
   if tester.include? n
     tester.delete(n)
     computer.push("white")
   end
 }
 while computer.length%4 !=0 || computer.empty? 
     computer.push("0")    
 end
 computer
end

def self.give_output(answer, guess)
     tester = answer.clone
   
    guess.each_with_index {|n, index|
      if n == tester[index]
        tester[index]=9
        @feedback.push("black")
      end
    }
    guess.each {|n|
      if tester.include? n
        tester.delete(n)
        @feedback.push("white")
      end
    }
    while @feedback.length%4 !=0 || @feedback.empty? 
        @feedback.push("0")
        
    end
    @feedback.last(4)
end

def self.game_loop
    
    self.new_game()
    if @choice == "b"
    while @feedback.last(4) != ["black", "black","black", "black"] && @feedback.length<=48
        self.get_input() 
        puts "Your feedback is #{self.give_output(@answer, @user_input.last(4))}"
        
    end
    
    elsif @choice == "s"
      self.computer_guesser()
    end
end
end

Play_game.game_loop()


