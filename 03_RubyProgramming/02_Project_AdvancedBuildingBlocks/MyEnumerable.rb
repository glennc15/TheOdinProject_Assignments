module Enumerable
	
	def my_each
		for item in self
			yield(item)
		end
	end

	def my_each_with_index
		idx_counter = 0
		for item in self
			yield(item, idx_counter)
			idx_counter += 1
		end
	end

	def my_select
		results = []
		self.my_each { |item| results << item if yield(item) }
		results
	end

	# def my_select
	# 	results = []
	# 	self.my_each do |item|
	# 		if yield(item)
	# 			results << item
	# 		end
	# 	end
	# 	results
	# end

	def my_all?
		self.my_each do |item|
			if block_given?
				return false unless yield(item)
			else
				return false unless item
			end
		end
		true
	end

	def my_any?
		found_any = false
		self.my_each do |item|
			if block_given?
				if yield(item)
					found_any = true
				end
			else
				if item
					found_any = true
				end
			end
		end
		found_any
	end

	def my_none?
		found_none = true
		self.my_each do |item|
			if block_given?
				if yield(item)
					found_none = false
				end
			else
				if item
					found_none = false
				end
			end
		end
		found_none
	end

	def my_count(arg=nil)
		count = 0
		self.my_each do |item|
			if block_given?
				count += 1 if yield(item)
			elsif arg 
				count += 1 if arg == item
			else
				count += 1 if item
			end
		end
		count 
	end

	def my_map(proc=nil)
		results = []
		self.my_each do |item|
			if block_given?
				results << yield(item)
			else
				results << proc.call(item)
			end
		end
		results
	end

	def my_inject(arg=nil)
		accumulator = arg ? arg : 0
		self.my_each do |item|
			accumulator = yield(accumulator, item)
		end
		accumulator
	end
end



# #each reminder:
# foo = [1, 5, 2, 9]
# foo.each { |item| puts item }

# Most (all?) of these tests are from the Ruby docs for Enumerable
# http://ruby-doc.org/core-2.2.2/Enumerable.html

# test of #my_each"
# foo.my_each { |item| puts item }

# test of #my_each_with_index:
# hash = Hash.new
# %w(cat dog wombat).my_each_with_index { |item, index|
#   hash[item] = index
# }
# puts hash

# # test of #my_select
# my_select_var =  [1,2,3,4,5].my_select { |num|  num.even?  }   #=> [2, 4]
# puts my_select_var.class
# print my_select_var
# puts

# # test of #my_all?
# puts %w[ant bear cat].my_all? { |word| word.length >= 3 } #=> true
# puts %w[ant bear cat].my_all? { |word| word.length >= 4 } #=> false
# puts [nil, true, 99].my_all?                              #=> false
# puts [true, true, 99].my_all?                             #=> true

# test of my_any?
# puts %w[ant bear cat].my_any? { |word| word.length >= 3 } #=> true
# puts %w[ant bear cat].my_any? { |word| word.length >= 4 } #=> true
# puts %w[ant bear cat].my_any? { |word| word.length >= 5 } #=> false
# puts [nil, true, 99].my_any?                              #=> true
# puts [nil, nil].my_any?                              	    #=> false

# test of my_none?
# puts %w{ant bear cat}.my_none? { |word| word.length == 5 } #=> true
# puts %w{ant bear cat}.my_none? { |word| word.length >= 4 } #=> false
# puts [].my_none?                                           #=> true
# puts [nil].my_none?                                        #=> true
# puts [nil, false].my_none?                                 #=> true

# test of my_count?
# ary = [1, 2, 4, 2]
# puts ary.my_count               #=> 4
# puts ary.my_count(2)            #=> 2
# puts ary.my_count{ |x| x%2==0 } #=> 3


# test of my_map
# print (1..4).my_map { |i| i*i }      #=> [1, 4, 9, 16]
# puts

# test_proc = Proc.new { |item| item*3 }
# print (1..4).my_map(test_proc)		 #=> [3, 6, 9, 12]
# puts 

# print (1..4).my_map(test_proc) { |i| i*i }      #=> [1, 4, 9, 16]
# puts

# test of my_inject
# puts (5..10).my_inject { |sum, n| sum + n }            #=> 45
# puts (5..10).my_inject(1) { |product, n| product * n } #=> 151200

# def multiply_els(arg_array)
# 	arg_array.my_inject(1) { |product, n| product * n }
# end

# puts multiply_els([2,4,5]) #=> 40


#