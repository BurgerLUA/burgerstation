var/global/language_seed = 1337

/proc/convert_langage_to_lizard(var/text)

	var/list/vowels = list(
		"a","e","i","o"
	)

	var/list/consonants = list( //And consonants pairs.
		"w","e","r","t",
		"y","p","s","d",
		"f","g","h","j",
		"k","l","z","x",
		"c","v","b","n",
		"m"
	)

	var/new_sentence = ""

	for(var/i=1,i<=length(text),i++)
		var/letter = getCharacter(text,i)
		var/was_upper = letter == uppertext(letter)
		letter = lowertext(letter)

		var/vowels_position = vowels.Find(letter)
		var/consonants_position = consonants.Find(letter)

		if(vowels_position)
			var/desired_index = vowels_position + language_seed
			var/this_character = vowels[1 + (desired_index % length(vowels))]
			if(was_upper)
				this_character = uppertext(this_character)

			new_sentence += this_character

		else if(consonants_position)
			var/desired_index = consonants_position + language_seed
			var/previous_character = lowertext(getCharacter(new_sentence,length(new_sentence)))
			var/this_character = consonants[1 + (desired_index % length(consonants))]
			if(previous_character == this_character)
				continue
			else if(previous_character in consonants)
				var/addition = vowels[1 + (desired_index % length(vowels))]
				if(was_upper)
					addition = uppertext(addition)
				new_sentence += "[addition]"

			if(was_upper)
				this_character = uppertext(this_character)

			new_sentence += this_character

		else
			if(was_upper)
				letter = uppertext(letter)
			new_sentence += letter

	return trim(new_sentence)
