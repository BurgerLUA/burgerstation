var/global/language_seed = 1337


/language/
	var/name //Name of Language
	var/id //ID of language

/language/proc/process_text(var/mob/speaker,var/text)
	return text