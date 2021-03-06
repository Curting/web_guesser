require "sinatra"

# Start with 6 guesses because the /index load counts
@@guesses = 6

set :number, rand(101)

def generate_number
  settings.number = rand(101)
end

def check_guess(guess)
  if !params.include?("guess")
    ["Enter your guess below:", "white"]
  else
    case guess - settings.number
      when 10..100 then ["Too damn high!", "red"]
      when 1...10 then ["A little too high...", "salmon"]
      when 0
        reset_game
        ["YAY! You guessed it. Let's try a new number.", "green"]
      when -10...0 then ["A little too low...", "salmon"]
      when -100..-11 then ["Waaaay too low!", "red"]
    end
  end
end

def reset_game
  @@guesses = 5
  generate_number
end

get '/' do
  guess = params["guess"].to_i
  evaluate = check_guess(guess)
  message = evaluate[0]
  background_color = evaluate[1]
  @@guesses -= 1
  
  # Was the guess wrong and the last one?
  if @@guesses == 0 && guess != settings.number
    message = "You had five guesses and you lost. Let's try a new number."
    background_color = "darkred"
    reset_game
  end
  
  erb :index, :locals => { :number => settings.number, :message => message, :background_color => background_color }
end