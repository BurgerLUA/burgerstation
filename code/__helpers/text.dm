#define ICON_TO_HTML(icon,icon_state,width,height) ("<IMG CLASS=icon src=\ref[icon] ICONSTATE='[icon_state]' style='width:[width]px;height:[height]px'>")

/proc/debug_args(var/proc_name,var/args)

	. = "[proc_name]("

	. += english_list(args,"null",",",",")

	. += ")"

	log_debug(.)

	return TRUE



/proc/scramble(var/text,var/strength = 50)

	. = ""

	for(var/word in splittext(text," "))
		for(var/letter in splittext(word,""))
			if(prob(strength))
				. += pick("!","@","#","$","%","^","&","*","(",")")
			else
				. += letter

	return .



/proc/deunderscore(var/text)
	return replacetextEx(text,"_"," ")

/proc/remove_trailing_punctuation(var/text)

	if(!text)
		return text

	var/regex/R = regex("\[!,.?\]+$")
	text = R.Replace(text,"")

	return text

/proc/police_input(var/client/caller,var/input, var/max_length = MAX_MESSAGE_LEN, var/capitalize = FALSE, var/periodize = FALSE)

	if(capitalize)
		input = capitalize(input)

	if(periodize)
		input = periodize(input)

	input = sanitize(input,max_length)

	if(caller && SSbadwords.has_badword(input))
		caller.to_chat(span("danger","Your text \"[input]\" contains one or more forbidden words and cannot be used."))
		return FALSE

	return input

//Skull132 made this
/proc/repeat_text(var/text_to_repeat, var/times_to_repeat=1)

    var/list/returning_list = list()

    for (var/i = 0; i < times_to_repeat; i++)
        returning_list += text_to_repeat

    return returning_list.Join("")

/proc/sanitize(var/input, var/max_length = MAX_MESSAGE_LEN, var/encode = 1, var/trim = 1, var/extra = 1)
	if(!input)
		return

	if(max_length)
		input = copytext(input,1,max_length)

	if(extra)
		input = replace_characters(input, list("\n"=" ","\t"=" "))

	if(encode)
		input = html_encode(input)
	else
		input = replace_characters(input, list("<"=" ", ">"=" "))

	if(trim)
		input = trim(input)

	return input

/proc/replace_characters(var/t,var/list/repl_chars)
	for(var/char in repl_chars)
		t = replacetext(t, char, repl_chars[char])
	return t

//Returns a string with reserved characters and spaces before the first letter removed
/proc/trim_left(text)
	for (var/i = 1 to length(text))
		if (text2ascii(text, i) > 32)
			return copytext(text, i)
	return ""

//Returns a string with reserved characters and spaces after the last letter removed
/proc/trim_right(text)
	for (var/i = length(text), i > 0, i--)
		if (text2ascii(text, i) > 32)
			return copytext(text, 1, i + 1)
	return ""

//Returns a string with reserved characters and spaces before the first word and after the last word removed.
/proc/trim(text)
	return trim_left(trim_right(text))

//Returns a string with the first element of the string capitalized.
/proc/capitalize(var/t as text)
	return uppertext(copytext(t, 1, 2)) + copytext(t, 2)

/proc/periodize(var/t as text)
	var/last_char = t[length(t)]

	var/static/list/valid_ends = make_associative(list(".",",","?","!"))

	if(!valid_ends[last_char])
		t += "."

	return t

/proc/get_filename(var/file_path)
	var/position = findlasttext(file_path,"/")
	return copytext(file_path,position)


/proc/getCharacter(string, pos=1) //Stolen from goon.
	return ascii2text(text2ascii(string, pos))


/proc/has_prefix(var/haystack,var/needle)
	if(length(needle) > length(haystack))
		return FALSE
	return copytext(haystack,1,length(needle)+1) == needle

/proc/has_suffix(var/haystack,var/needle)
	if(length(needle) > length(haystack))
		return FALSE
	return copytext(haystack,-length(needle),0) == needle

/proc/get_pronoun_he_she_it(var/mob/M)
	switch(M.gender)
		if(MALE)
			return "he"
		if(FEMALE)
			return "she"

	return "it"

/proc/get_pronoun_his_her_their(var/mob/M)
	switch(M.gender)
		if(MALE)
			return "his"
		if(FEMALE)
			return "her"
	return "their"

/proc/proper_url_encode(var/input)
	return url_encode(replacetextEx(input,"\n",""))
