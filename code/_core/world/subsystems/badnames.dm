var/global/list/all_badnames = list()

/subsystem/badnames/
	name = "Bad names Subsystem"
	desc = "Stores all the badwords for use in LIBERAL CENSORSHIP."
	priority = SS_ORDER_PRELOAD

/subsystem/badnames/Initialize()

	var/badnames = file2text(BADNAMES)

	all_badnames = splittext(badnames,"\n")

	LOG_SERVER("Found [length(all_badnames)] bad names.")

	return TRUE