
require "sinatra"
require "sinatra/reloader"

number = rand(101)

get '/' do
  "The secret number is #{number}."
end