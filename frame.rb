
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
		time_value_of_money
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
	
	def self.time_value_of_money
	
		tvm_beta = Company.beta
		tvm_sector_beta = Company.sector_beta
		tvm_years = Company.years
	 
		@@companies.map do |company, value|
			present_value = value[:expected_share_value]
			future_growth = (1 + tvm_sector_beta + tvm_beta)
			interest_rate = (1 + tvm_beta)
			years_out = tvm_years
		
			value[:expected_share_value] = (present_value*(future_growth**years_out))/((interest_rate)**years_out)
		end
	end

	
	def self.beta
		puts "What do you think the market will grow at?"
		gets.chomp.to_f/100
	end	

	def self.sector_beta
		puts "Do you think this sector will grow faster than other sectors?"
		gets.chomp.to_f/100
	end
	
	def self.years
		puts "How long do you think this will continue for?  10 years? 20 years? 30 years?"
		gets.chomp.to_f
	end
	
end