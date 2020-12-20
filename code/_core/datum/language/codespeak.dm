/language/codespeak
	name = "Codespeak"
	id = LANGUAGE_CODESPEAK

/language/codespeak/process_text(var/speaker,var/text)

	var/widsom_length = length(SStext.wisdoms)

	if(!widsom_length)
		return "Penis."

	var/number = 1

	for(var/i=1,i<=min(10,widsom_length),i++)
		number += text2ascii(text,i)

	number = (number % widsom_length) + 1

	if(SStext.wisdoms[number])
		return SStext.wisdoms[number]

	return pick(SStext.wisdoms)