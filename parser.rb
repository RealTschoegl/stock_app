require 'csv'
stocks = {}

CSV.foreach("112prfu.csv", :headers => true, :header_converters => :symbol, :converters => :all) do |row|
    free_cash_flow = row[:market_cap].to_f / row[:price_to_free_cash_flow_mrq].to_f
	stocks[row[:description].to_s] = free_cash_flow
	
end


stocks.each do |key, value|
	puts key
	puts value
end
