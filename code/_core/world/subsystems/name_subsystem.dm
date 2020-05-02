


SUBSYSTEM_DEF(name)
	name = "Name Subsystem"
	desc = "Stores random names in a list and keeps track of possibly duplicate names."
	priority = SS_ORDER_PRELOAD

	var/list/first_names_male = list()
	var/list/first_names_female = list()
	var/list/last_names = list()
	var/list/name_count = list()

	var/list/adjectives = list()
	var/list/verbs = list()

/subsystem/name/Initialize()

	first_names_male = splittext(file2text('text/names/first_male.txt'),"\n")
	first_names_female = splittext(file2text('text/names/first_female.txt'),"\n")
	last_names = splittext(file2text('text/names/last.txt'),"\n")

	adjectives = splittext(file2text('text/names/adjectives.txt'),"\n")
	verbs = splittext(file2text('text/names/verbs.txt'),"\n")

	log_subsystem(name,"Found [length(first_names_male)] male first names.")
	log_subsystem(name,"Found [length(first_names_female)] female first names.")
	log_subsystem(name,"Found [length(last_names)] last names.")

	return TRUE

/subsystem/name/proc/check_duplicate_name(var/name)
	if(name_count[name])
		name_count[name]++
		return "[name] ([name_count[name]])"
	else
		name_count[name] = rand(1,999) //One funny thing is that you can tell at least how many of this type exists by starting it at 1, so it's random.
		return "[name] ([name_count[name]])"