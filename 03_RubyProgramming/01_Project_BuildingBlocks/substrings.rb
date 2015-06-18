def search_dictionary(word, dictionary)
	group_sizes = word.length
	results = {}
	word.downcase!
	group_sizes.times do |group_size|
	# 0.upto(group_sizes) do |group_size|
		group_size.upto(group_sizes-1) do |group|
			idx_end = group
			idx_begin = idx_end - group_size
			# puts "idx_begin: #{idx_begin}, idx_end: #{idx_end}"
			new_word = word[idx_begin..idx_end]
			new_word_dict_count = dictionary.count(new_word)
			if new_word_dict_count > 0
				results[new_word] = new_word_dict_count
			end
		end
	end
	return results
end

def merge_hashes(destinaton_hash, source_hash)
	source_hash.keys.each do |key|
		# puts key
		if destinaton_hash.key?(key)
			destinaton_hash[key] += source_hash[key]
		else
			destinaton_hash[key] = source_hash[key]
		end
	end
	return destinaton_hash
end

def substrings(search_words, dictionary)
	results ={}
	search_words.scan(/[A-Za-z]+'?[A-Za-z]*/) do |word|
		these_results = search_dictionary(word, dictionary)
		results = merge_hashes(results, these_results)

		# results =  results.merge(search_dictionary(word, dictionary))
	end
	puts results
end

# Problem: Implement a method #substrings that takes a word as the first
# argument and then an array of valid substrings (your dictionary) as the
# second argument. It should return a hash listing each substring (case
# insensitive) that was found in the original string and how many times it was
# found.
# 
# Steps:
# 
# 1) Convert the input string into a list of searchable words.
# 
# 2) for each word in the search string break the word into it's possible
# substrings.
# 
# example: break "below" into it's all it's substrings:
# "b" "e" "l" "o" "w"
# "be" "el" "lo" "ow"
# "bel" "elo" "low"
# "belo" "elow"
# "below"
# 
# 3) Create a dictionary with each substring as a key (if it appears in
# dictinary[]) and the number of times it appears in dictionary[].
# 
# 4) merge the smaller dictionaries from step 3 into a larger dictionary that
# contains the counts for all words and substrings.

dictionary = ["below","down","go","going","horn","how","howdy","it","i","low","own","part","partner","sit"]

substrings("below", dictionary)
substrings("Howdy partner, sit down! How's it going?", dictionary)

# puts letter_groups("below", dictionary)
# puts letter_groups("Howdy partner, sit down! How's it going?", dictionary)

# puts search_dictionary("below", dictionary)

# hash1 = {"low"=>1, "below"=>1}
# hash2 = {"low"=>1, "below"=>3, "part" => 5}

# puts merge_hashes(hash2, hash1)

5.times do |jump_num|
	print "Jump #{jump_num}!"
end
