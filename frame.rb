class Company

require 'yahoofinance'

@@risk_free_rate = 0.0141 #5 year treasury yield at market
@@market_growth_rate = 0.2038 #S&P500 1 year growth rate

@@companies = {
	"GOOG" => {
		:free_cash_flow => 16500,
		:num_shares => 332, 
		:PE_ratio => 25.8,
		:dividend_per_share => 0, #Forward Annual Dividend Rate
		:dividend_growth_rate => 0, #Forward Annual Dividend Yield
		:beta => 1.19,
		:cost_of_equity => 0,
		:current_stock_price => 0,
		:expected_share_value => 0,
		:capm_share_value => 0,
		:dividend_share_value => 0,
		:composite_share_value => 0
		},
	"MSFT" => {
		:free_cash_flow => 31626,
		:num_shares => 8350,
		:PE_ratio => 17.5,
		:dividend_per_share => 0.92,
		:dividend_growth_rate => 0.028,
		:beta => 1.10,
		:cost_of_equity => 0,
		:current_stock_price => 0,
		:expected_share_value => 0, 
		:capm_share_value => 0,
		:dividend_share_value => 0,
		:composite_share_value => 0
		},
	"YHOO" => {
		:free_cash_flow => -281,
		:num_shares => 1008,
		:PE_ratio => 6.67,
		:dividend_per_share => 0,
		:dividend_growth_rate => 0,
		:beta => 0.89,
		:cost_of_equity => 0,
		:current_stock_price => 0,
		:expected_share_value => 0,
		:capm_share_value => 0,
		:dividend_share_value => 0,
		:composite_share_value => 0
		},
	"FB" => {
		:free_cash_flow => 1612,
		:num_shares => 2420,
		:PE_ratio => 872,
		:dividend_per_share => 0,
		:dividend_growth_rate => 0,
		:beta => 1.33,
		:cost_of_equity => 0,
		:current_stock_price => 10,
		:expected_share_value => 0,
		:capm_share_value => 0,
		:dividend_share_value => 0,
		:composite_share_value => 0
		}
}
	def self.composite_valuation
		free_cash_flow_method
		dividend_discount_model
		capm_method
		@@companies.map do |company, value|
			if value[:dividend_per_share] == 0
				value[:composite_share_value] += ((value[:expected_share_value].to_f + value[:capm_share_value].to_f)/2).round(2)
			else
				value[:composite_share_value] += ((value[:expected_share_value].to_f + value[:dividend_share_value].to_f + value[:capm_share_value].to_f)/3).round(2)
			end
		end
	end

	def self.free_cash_flow_method
		get_cost_of_equity
		@@companies.map do |company, value|
			value[:expected_share_value] += value[:free_cash_flow]/(value[:cost_of_equity]-(value[:PE_ratio]/100))
		end
		num_shares
	end
	
	def self.dividend_discount_model
		get_stock_prices
		@@companies.map do |company, value|
			rate_of_return = (value[:dividend_per_share]/value[:current_stock_price]) + value[:dividend_growth_rate]
			value[:dividend_share_value] += value[:dividend_per_share]/(rate_of_return - value[:dividend_growth_rate])
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
	
	def self.get_cost_of_equity
		@@companies.map do |company, value|
			value[:cost_of_equity] = @@risk_free_rate + value[:beta] * (@@market_growth_rate - @@risk_free_rate)
		end
	end
	
	def self.capm_method
		capm_years = years
		get_cost_of_equity
		get_stock_prices
		@@companies.map do |company, value|
			value[:capm_share_value] += (value[:cost_of_equity] + 1) * capm_years * value[:current_stock_price]
		end
	end
	
	def self.num_shares
		@@companies.map do |company, value|
			value[:expected_share_value] = (value[:expected_share_value].to_f/value[:num_shares].to_f).round(2)
		end
	end
	
	def self.years
		puts "How many years do you want to hold the stock for?"
		gets.chomp.to_f
	end
	
end