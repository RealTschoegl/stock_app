class Company

@risk_free_rate = .0141 #5 year treasury yield at market
@market_growth_rate = .2038 #S&P500 1 year growth rate

@@companies = {
	"GOOG" => {
		:free_cash_flow => 16500,
		:cash_on_hand => 50100,
		:num_shares => 332, 
		:PE_ratio => 25.8,
		:beta => 1.19,
		:expected_share_value => 0,
		:composite_share_value => 0
		},
	"MSFT" => {
		:free_cash_flow => 31626,
		:cash_on_hand => 73790,
		:num_shares => 8350,
		:PE_ratio => 17.5,
		:beta => 1.10,
		:expected_share_value => 0, 
		:composite_share_value => 0
		},
	"YHOO" => {
		:free_cash_flow => -281,
		:cash_on_hand => 3010,
		:num_shares => 1008,
		:PE_ratio => 6.67,
		:beta => .89,
		:expected_share_value => 0,
		:composite_share_value => 0
		},
	"FB" => {
		:free_cash_flow => 1612,
		:cash_on_hand => 15103,
		:num_shares => 2420,
		:PE_ratio => 872,
		:beta => 1.33,
		:expected_share_value => 0,
		:composite_share_value => 0
		}
}
	def self.composite_valuation
		puts (free_cash_flow_method + divided_discount_model + capm_method)/3
	end

	def self.free_cash_flow_method
		add_cash_flow
		add_cash_on_hand
		time_value_of_money
		num_shares
	end
	
	# def self.dividend_discount_model
		# Value = Dividend per share / (Discount rate - dividend growth rate)
	# end
	
	def self.capm_method
		@@companies.map do |company, value|
			rate_of_return = @risk_free_rate + value[:beta](@market_growth_rate - @risk_free_rate)
			value[:composite_share_value] = (rate_of_return + 1) * years * current_stockprice
		end
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
		puts "How many years do you want to hold the stock for?"
		gets.chomp.to_f
	end
	
end