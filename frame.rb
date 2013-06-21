
class Company

@@companies = {
	"GOOG" => {
		:free_cash_flow => 16500,
		:cash_on_hand => 50100,
		:num_shares => 332, 
		:expected_share_value => 0
		},
	"MSFT" => {
		:free_cash_flow => 31626,
		:cash_on_hand => 73790,
		:num_shares => 8350,
		:expected_share_value => 0
		},
	"YHOO" => {
		:free_cash_flow => -281,
		:cash_on_hand => 3010,
		:num_shares => 1008,
		:expected_share_value => 0
		},
	"FB" => {
		:free_cash_flow => 1612,
		:cash_on_hand => 15103,
		:num_shares => 2420,
		:expected_share_value => 0
		}
}

	def self.aggregator
		add_cash_flow
		add_cash_on_hand
		num_shares
	end
	

	def self.add_cash_flow
		@@companies.map do |company, value|
			value[:expected_share_value] += value[:free_cash_flow]
		end
	end
	
	def self.add_cash_on_hand
		@@companies.map do |company, value|
			value[:expected_share_value] += value[:cash_on_hand]
		end
	end
	
	def self.num_shares
		@@companies.map do |company, value|
			value[:expected_share_value] = (value[:expected_share_value].to_f/value[:num_shares].to_f).round(2)
		end
	end
	
	def self.assignment_test
		@@companies.each do |company, value|
			puts company, value[:free_cash_flow], value[:cash_on_hand]
		end
	end
	
	#def time_value_of_money
	#	present value = future value / (1 + interest rate)^number of years
	#end

	
	#def interest_rate
	#	puts "What do you think the market will grow at?"
	#	growth_rate = gets.chomp.to_f
	#end	

	#def growth_rate
	#	puts "Do you think this sector will grow faster than other sectors?"
	#	growth_rate = gets.chomp.to_f
	#end
	
	#def years
	#	puts "How long do you think this will continue for?  10 years? 20 years? 30 years?"
	#	years_estimate = gets.chomp.to_f
	#end
	
end