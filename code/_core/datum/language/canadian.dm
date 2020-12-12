/language/canadian
	name = "Canadian"
	id = LANGUAGE_CANADIAN

/language/canadian/process_text(var/speaker,var/text)
	text = remove_trailing_punctuation(text)
	text = replacetextEx(text,"ou","oo")
	text = "[text], eh?"
	return text