#define ICON_TO_TEXT(icon,icon_state) <img class='icon' src=\ref[icon] ICONSTATE='[icon_state]'>

/proc/police_input(var/input, var/max_length = MAX_MESSAGE_LEN, var/capitalize = FALSE, var/periodize = FALSE)

	/*
	for(var/badword in all_badwords)
		input = replacetextEx(input, badword, repeat_text("*",length(badword)))
	*/

	if(capitalize)
		input = capitalize(input)

	if(periodize)
		input = periodize(input)

	input = sanitize(input,max_length)

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
	var/last_char = copytext(t,length(t),length(t)+1)

	var/list/valid_ends = list(".",",","?","!")

	if(!(last_char in valid_ends))
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


/proc/get_pronoun(var/mob/M)
	switch(M.gender)
		if(MALE)
			return "he"
		if(FEMALE)
			return "she"

	return "they"


#define datum2text(x) "[x.name]([x.type])"
#define atom2text(x) "[x.name]([x.type])([x.x][x.y])"


/proc/proper_url_encode(var/input)
	return url_encode(replacetextEx(input,"\n",""))
