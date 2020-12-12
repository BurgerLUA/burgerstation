/language/binary
	name = "Binary"
	id = LANGUAGE_BINARY

/language/binary/process_text(var/speaker,var/text)

	var/regex/R = regex("\[!,.?\]")
	text = R.Replace(text,"")

	var/returning = ""

	for(var/i=1,i<=length(text),i++)
		returning = "[returning][text2ascii(text,i) % 2]"

	return "[trim(returning)]."