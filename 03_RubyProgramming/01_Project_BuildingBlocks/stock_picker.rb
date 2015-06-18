def stock_picker(stock_prices)
	# Finds the greatest distance between two values in the array. Only
	# concerned with greatest distance. Use two loops:

	# Outer loop (buy_idx): range begin : 0 ; range end: stock_prices-1
	#
	# inner loop (end value): range begin : buy_idx ; range end: stock_prices-1
	# 
	# example search space: [8, 7, 6]
	# indicies to search: (0, 1), (0, 2), (1, 2)
	# 
	# Check the distance between the two values and update the max as
	# required.

	buy_day = 0
	sell_day = 0
	max_value = 0
	if stock_prices.length > 1
		(stock_prices.length-1).times do |buy_idx|
			(buy_idx+1).upto(stock_prices.length-1) do |sell_idx|
				potential_new_max = stock_prices[sell_idx] - stock_prices[buy_idx]
				if max_value < potential_new_max
					buy_day = buy_idx
					sell_day = sell_idx
					max_value = potential_new_max
				end
			end
		end
	end
	puts [buy_day, sell_day].to_s
end

# stock_picker([17,3,6,9,15,8,6,1,10])
# stock_picker([17,3,6,9])
# stock_picker([17,3,6,9,15,8,6,1,20])
# stock_picker([3,6])
# stock_picker([7,6])
# stock_picker([3])
# stock_picker([])
# stock_picker([17, 9, 3])







