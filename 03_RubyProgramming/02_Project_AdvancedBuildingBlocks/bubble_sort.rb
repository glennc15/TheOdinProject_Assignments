#!/usr/bin/ruby

# def bubble_sort(sort_array)
# 	# n is used to limit the size of the sub array that has to be sorted. The
# 	# first past of Bubble Sort guarantees that the largest value is in the
# 	# correct posiiton, the 2nd pass guarantees the second largest value is in
# 	# the correct position, and so on. So once the 1st pass is complete the
# 	# last element of the array does not need to be checked since we know it's
# 	# already in correct sorted order. So on the second pass only needs to
# 	# sort elements 0 thru array.length-2. The the 2nd pass only needs to sort
# 	# elements 0 thru array.length-3, and so on.
# 	n = sort_array.length
# 	loop do
# 		swapped = false
# 		1.upto(n-1) do |idx|
# 			if sort_array[idx] < sort_array[idx-1]
# 				sort_array[idx], sort_array[idx-1] = sort_array[idx-1], sort_array[idx]
# 				swapped = true
# 			end
# 		end
# 		n -= 1
# 		break if !swapped
# 	end
# 	return sort_array
# end

def bubble_sort_by(sort_array)
	# n is used to limit the size of the sub array that has to be sorted. The
	# first past of Bubble Sort guarantees that the largest value is in the
	# correct posiiton, the 2nd pass guarantees the second largest value is in
	# the correct position, and so on. So once the 1st pass is complete the
	# last element of the array does not need to be checked since we know it's
	# already in correct sorted order. So on the second pass only needs to
	# sort elements 0 thru array.length-2. The the 2nd pass only needs to sort
	# elements 0 thru array.length-3, and so on.
	n = sort_array.length
	loop do
		swapped = false
		1.upto(n-1) do |idx|
			# swap the two elements if N_(x) < N_(x-1). Use a block passed in
			# to define what <, >, or equality means for this array.
			if yield(sort_array[idx-1], sort_array[idx]) < 0
				sort_array[idx], sort_array[idx-1] = sort_array[idx-1], sort_array[idx]
				swapped = true
			end
		end
		n -= 1
		break if !swapped
	end
	return sort_array
end

# bubble_sort refactored to use #bubble_sort_by
def bubble_sort(sort_array)
	sort_array = bubble_sort_by(sort_array) { |left, right| right <=> left }
	return sort_array
end


print bubble_sort([4,3,78,2,0,2])
puts ""

sort_array = bubble_sort_by(["hi","hello","hey"]) do |left,right|
	right.length - left.length
end

print sort_array
puts " "
 
# => ["hi", "hey", "hello"]
