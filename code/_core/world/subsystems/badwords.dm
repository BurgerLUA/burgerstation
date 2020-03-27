var/global/list/all_badwords = list()

SUBSYSTEM_DEF(badwords)
	name = "Badwords Subsystem"
	desc = "Stores all the badwords for use in LIBERAL CENSORSHIP."
	priority = SS_ORDER_PRELOAD

/subsystem/badwords/Initialize()

	var/badwords = file2text(BADWORDS)

	all_badwords = splittext(badwords,"\n")

	log_subsystem(name,"Found [length(all_badwords)] bad words.")

	return TRUE