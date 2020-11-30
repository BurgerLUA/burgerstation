/language/codespeak
	name = "Codespeak"
	id = LANGUAGE_CODESPEAK

/language/codespeak/process_text(var/speaker,var/text)

	var/widsom_length = length(SSname.wisdoms)

	if(!widsom_length)
		return "Penis."

	var/number = 1

	for(var/i=1,i<=min(10,widsom_length),i++)
		number += text2ascii(text,i)

	number = (number % widsom_length) + 1

	if(SSname.wisdoms[number])
		return SSname.wisdoms[number]

	return pick(SSname.wisdoms)