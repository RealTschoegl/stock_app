class Company

require 'yahoofinance'

@@risk_free_rate = 0.0141 #5 year treasury yield at market
@@market_growth_rate = 0.2038 #S&P500 1 year growth rate

@@companies = {
	"GOOG" => {
		:free_cash_flow => 16500,
		:cash_on_hand => 50100,
		:num_shares => 332, 
		:PE_ratio => 25.8,
		:dividend_per_share => 0, #Forward Annual Dividend Rate
		:dividend_growth_rate => 0, #Forward Annual Dividend Yield
		:beta => 1.19,
		:current_stock_price => 0,
		:expected_share_value => 0,
		:capm_share_value => 0,
		:dividend_share_value => 0,
		:composite_share_value => 0
		},
	"MSFT" => {
		:free_cash_flow => 31626,
		:cash_on_hand => 73790,
		:num_shares => 8350,
		:PE_ratio => 17.5,
		:dividend_per_share => 0.92,
		:dividend_growth_rate => 0.028,
		:beta => 1.10,
		:current_stock_price => 0,
		:expected_share_value => 0, 
		:capm_share_value => 0,
		:dividend_share_value => 0,
		:composite_share_value => 0
		},
	"YHOO" => {
		:free_cash_flow => -281,
		:cash_on_hand => 3010,
		:num_shares => 1008,
		:PE_ratio => 6.67,
		:dividend_per_share => 0,
		:dividend_growth_rate => 0,
		:beta => 0.89,
		:current_stock_price => 0,
		:expected_share_value => 0,
		:capm_share_value => 0,
		:dividend_share_value => 0,
		:composite_share_value => 0
		},
	"FB" => {
		:free_cash_flow => 1612,
		:cash_on_hand => 15103,
		:num_shares => 2420,
		:PE_ratio => 872,
		:dividend_per_share => 0,
		:dividend_growth_rate => 0,
		:beta => 1.33,
		:current_stock_price => 10,
		:expected_share_value => 0,
		:capm_share_value => 0,
		:dividend_share_value => 0,
		:composite_share_value => 0
		}
}
	def self.composite_valuation
		@@companies.map do |company, value|
			value[:composite_share_value} += (value[:expected_share_value] + value[:dividend_share_value] + value[:capm_share_value])/3
		end
	end

	def self.free_cash_flow_method
		add_cash_flow
		add_cash_on_hand
		time_value_of_money
		num_shares
	end
	
	def self.dividend_discount_model
		@@companies.map do |company, value|
			cost_of_equity = (value[:dividend_per_share]/[:current_stock_price]) + value[:dividend_growth_rate]
			value[:dividend_share_value} += value[:dividend_per_share]/( cost_of_equity - value[:dividend_growth_rate])
		end
	end
	
	def self.get_stock_prices
		@@companies.each do |company, value|
			quote_type = YahooFinance::StandardQuote
			quote_symbols = "#{company}"
			YahooFinance::get_quotes(quote_type, quote_symbols) do |qt|
				value[:current_stock_price] += qt.lastTrade
			end
		end
	end
	
	def self.capm_method
		capm_years = years
		@@companies.map do |company, value|
			rate_of_return = @@risk_free_rate + value[:beta] * (@@market_growth_rate - @@risk_free_rate)
			value[:capm_share_value] += (rate_of_return + 1) * capm_years * value[:current_stock_price]
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