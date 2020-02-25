
/subsystem/badnames/
	name = "Bad names Subsystem"
	desc = "Stores all the badwords for use in LIBERAL CENSORSHIP."
	priority = SS_ORDER_PRELOAD
	var/list/all_badnames = list()

/subsystem/badnames/Initialize()

	var/badnames = file2text(BADNAMES)
	if(!badnames)
		return

	all_badnames = make_associative(splittext(badnames,"\n"))

	LOG_SERVER("Found [length(all_badnames)] bad names.")

	return TRUE