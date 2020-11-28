/language/cult
	name = "Cult"
	id = LANGUAGE_CULT

/language/cult/process_text(var/speaker,var/text)

	var/static/list/vowels = make_associative(list(
		"y","'","u","x","v",
		"'","'","'","'","'",
		"a","e","i","o"
	))

	var/static/list/consonants = make_associative(list( //And consonants pairs.
		"w","r","t","s","d",
		"f","g","h","k","l",
		"z","c","b","n"
	))

	var/new_sentence = ""

	for(var/i in 1 to length(text))
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
			else if(consonants[previous_character])
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