require 'sinatra'
require 'sinatra/reloader'


# If a GET request comes in at /, do the following.

get '/' do
  # Get the parameter named guess and store it in pg
  tru = params['true']
  fal = params['false']
	size = params['size']
	table = params['table']
	@bad_param = false
	@gen_table = nil
	
	if table.nil?
			@gen_table = nil
	else
			@gen_table = 1
	end

  if tru.nil?
		@truth = 'T'
	elsif tru == ''
		@truth = 'T'
	elsif tru.length > 1
		@bad_param = true
		not_found
	else
		@truth = tru
	end
	
	if fal.nil?
		@falseth = 'F'
	elsif fal == ''
		@falseth = 'F'
	elsif fal.length > 1
		@bad_param = true
		not_found
	else
		@falseth = fal
	end
	
	if size.nil?
		@size_table = 3
	elsif size == ''
		@size_table = 3
	else
		unless size.is_i?
			@bad_param = true
			not_found
		end
		@size_table = size.to_i
		if @size_table < 2
			@bad_param = true
			not_found
		end
			
  end
	
	if @truth == @falseth
		@bad_param = true
		not_found
	end
	
	create_table_arr
  erb :index
end

def create_table_arr 	
@operators = []
@AOX
#0.upto((2**s)-1).each { |n| puts ("%0" + s.to_s + "b") % n }

	for n in (0..((2**@size_table)-1))
		v = (("%0" + @size_table.to_s + "b") % n)
		op = v.split('')

		for i in (0..(@size_table-1))
			@operators << op[i]
		end

		@AOX = 0
		
		for i in (0..(op.size-1))
			if op[i] == 1.to_s
				@AOX += 1
			end
		end
		
		if @AOX == op.size
			@operators << 1
		else
			@operators << 0
		end
		
		if @AOX > 0
			@operators << 1
		else
			@operators << 0
		end
		
		if @AOX % 2 == 1
			@operators << 1
		else
			@operators << 0
		end
		
	end
	
end

not_found do
  status 404
  erb :error
end

class String
    def is_i?
       /\A[-+]?\d+\z/ === self
    end
end


