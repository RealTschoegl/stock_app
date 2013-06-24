require 'yahoofinance'

# Set the type of quote we want to retrieve.
# Available type are:
#  - YahooFinance::StandardQuote
#  - YahooFinance::ExtendedQuote
#  - YahooFinance::RealTimeQuote
quote_type = YahooFinance::StandardQuote

# Set the symbols for which we want to retrieve quotes.
# You can include more than one symbol by separating
# them with a ',' (comma).
quote_symbols = "yhoo,goog,msft,fb"

# Get the quotes from Yahoo! Finance.  The get_quotes method call
# returns a Hash containing one quote object of type "quote_type" for
# each symbol in "quote_symbols".  If a block is given, it will be
# called with the quote object (as in the example below).

# YahooFinance::get_quotes( quote_type, quote_symbols ) do |qt|
    # puts "QUOTING: #{qt.symbol}"
    # puts qt.to_s
# end

YahooFinance::get_quotes( quote_type, quote_symbols ) do |qt|
    puts "Quote: #{qt.symbol}"
    puts qt.lastTrade
end