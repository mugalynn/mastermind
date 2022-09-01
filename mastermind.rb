class Play_game

def self.new_game
    @user_input=Array.new
    @answer=Array.new(4) {rand(0..5)}
    @feedback=Array.new
    
    
    puts "We are going to play Mastermind! The computer has selected 4 balls and placed them in a specific order to make a code."
    puts "the secret code is #{@answer}"  
    puts @feedback.empty?
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
        @feedback.push(0)
        
    end
    @feedback.last(4).shuffle
end

def self.game_loop
    
    self.new_game()
    while @feedback.last(4) != ["black", "black","black", "black"] && @feedback.length<=48
        self.get_input() 
        puts "Your feedback is #{self.give_output(@answer, @user_input.last(4))}"
        
    end
end
end

Play_game.game_loop()


