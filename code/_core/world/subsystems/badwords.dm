#define BADWORDS "data/server/badwords.txt"

SUBSYSTEM_DEF(badwords)
	name = "Badwords Subsystem"
	desc = "Stores all the badwords for use in LIBERAL CENSORSHIP."
	priority = SS_ORDER_FIRST
	var/list/regex/bad_word_regex = list()

	var/regex/space_regex

/subsystem/badwords/Initialize()
	space_regex = regex(@{"[^A-z]"},"ig")
	load_badwords()
	return ..()

/subsystem/badwords/proc/load_badwords()
	bad_word_regex = list()
	if(fexists(BADWORDS))
		var/r_file = trim(rustg_file_read(BADWORDS))
		if(r_file)
			for(var/r_text in splittext(r_file,"\n"))
				try
					bad_word_regex += regex(r_text,"i") //Does not need global here because we only need to find it once.
				catch
					log_error("Failed to parse regex string \"[r_text]\"!")
			log_subsystem(name,"Found bad words file and created a regex list of [length(bad_word_regex)] bad words.")
		else
			log_subsystem(name,"Found bad words file, but it was empty.")
	else
		log_subsystem(name,"Could not find a bad words file.")

	return TRUE

/subsystem/badwords/proc/has_badword(text_to_check)


	if(!space_regex || !text_to_check || !length(bad_word_regex))
		return FALSE

	text_to_check = space_regex.Replace(text_to_check,"")

	if(!text_to_check)
		return FALSE

	. = null

	for(var/k in bad_word_regex)
		var/regex/R = k
		var/result = R.Find(text_to_check)
		if(result)
			. = result
			break

