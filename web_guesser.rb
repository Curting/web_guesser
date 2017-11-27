
require "sinatra"
require "sinatra/reloader"

SECRET_NUMBER = rand(101)

def check_guess(guess)
  case guess - SECRET_NUMBER
    when 10..100 then "Too damn high!"
    when 1...10 then "A little too high..."
    when 0 then "YAY! You guessed it."
    when -10...0 then "A little too low..."
    when -100..-11 then "Waaaay too low!"
  end
end


get '/' do
  guess = params["guess"].to_i
  message = check_guess(guess)
  erb :index, :locals => {:number => SECRET_NUMBER, :message => message}
end