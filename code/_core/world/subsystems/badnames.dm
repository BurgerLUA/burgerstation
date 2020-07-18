
SUBSYSTEM_DEF(badnames)
	name = "Bad names Subsystem"
	desc = "Stores all the badwords for use in LIBERAL CENSORSHIP."
	priority = SS_ORDER_PRELOAD
	var/list/all_badnames = list()

/subsystem/badnames/Initialize()

	var/badnames = rustg_file_read(BADNAMES)
	if(!badnames)
		return

	all_badnames = make_associative(splittext(badnames,"\n"))

	log_subsystem(name,"Found [length(all_badnames)] bad names.")

	return ..()