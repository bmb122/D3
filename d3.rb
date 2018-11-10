require 'sinatra'
require 'sinatra/reloader'

# The secret number to guess.  This will start as an invalid value
gen_table = false

def setTT()
	gen_table = true
end

# If a GET request comes in at /, do the following.

get '/' do
  # Get the parameter named guess and store it in pg
  tru = params['true']
  fal = params['false']
	size = params['size']
	table = params['table']
	gen_table = nil
	if table.nil?
			gen_table = nil
	else
			gen_table = 1
	end
  # Setting these variables here so that they are accessible
  # outside the conditional
  #guess = -1
  #got_it = false
  # If there was no guess parameter, this is a brand new game.
  # Generate a secret number and set the guess to nil.
  if tru.nil?
		truth = 'T'
	elsif tru.length > 1
		not_found
	end
	if fal.nil?
		falseth = 'F'
	elsif fal.length > 1
		not_found
	end
	if size.nil?
		size_table = 3
  end
  erb :index, :locals => { truth: truth, falseth: falseth, size_table: size_table, gen_table: gen_table }
end

not_found do
  status 404
  erb :error
end
