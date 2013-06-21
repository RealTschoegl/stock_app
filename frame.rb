@companies = {"GOOG" => 0, "MSFT" => 0, "YHOO" => 0, "FB" => 0}
@free_cash_flow = { :GOOG => 16500, :MSFT => 31626, :YHOO => -281, :FB =>  1612 }
cash_on_hand = { :GOOG => 50100, :MSFT => 73790, :YHOO => 3010, :FB => 15103 }
debt = { :GOOG => 22083, :MSFT => 54908, :YHOO => 2543, :FB => 2260 }
assets = { :GOOG => 93798, :MSFT => 121271, :YHOO => 17108, :FB => 3348 }
num_shares = { :GOOG => 332, :MSFT => 8350, :YHOO => 1008, :FB => 2420 }

@stock_prices = {}

	def collective
		assign_hash
		add_cash_flow
		puts @stock_prices
	end
	
	def assign_hash
		@companies.each do |company, value|
			@stock_prices[company] = value 
		end
	end

	def add_cash_flow
		@free_cash_flow.each do |company, value|
			if @stock_prices.has_key?(company)
				@stock_prices[company] += value
			else
			end
		end
	end

	def cash_on_hand

	end
	
	def time_value_of_money
		present value = future value / (1 + interest rate)^number of years
	end

	
	def interest_rate
		puts "What do you think the market will grow at?"
		growth_rate = gets.chomp.to_f
	end	
	
	def years
		puts "How long do you think this will continue for?  10 years? 20 years? 30 years?"
		years_estimate = gets.chomp.to_f
	end
	
	def num_shares

	end