
require "sinatra"
require "sinatra/reloader"

set :number, rand(101)

def check_guess(guess)
  case guess - settings.number
    when 10..100 then ["Too damn high!", "red"]
    when 1...10 then ["A little too high...", "salmon"]
    when 0 then ["YAY! You guessed it.", "green"]
    when -10...0 then ["A little too low...", "salmon"]
    when -100..-11 then ["Waaaay too low!", "red"]
  end
end


get '/' do
  guess = params["guess"].to_i
  evaluate = check_guess(guess)
  message = evaluate[0]
  background_color = evaluate[1]
  erb :index, :locals => {:number => settings.number, :message => message, :background_color => background_color}
end