SUBSYSTEM_DEF(text)
	name = "text Subsystem"
	desc = "Stores random names in a list and keeps track of possibly duplicate names."
	priority = SS_ORDER_PRELOAD

	var/list/first_names_male = list()
	var/list/first_names_female = list()
	var/list/last_names = list()
	var/list/name_count = list()

	var/list/first_codenames = list()
	var/list/last_codenames = list()

	var/list/adjectives = list()
	var/list/verbs = list()

	var/list/player_names = list()

	var/list/wisdoms = list()

/subsystem/text/Initialize()

	first_names_male = splittext(rustg_file_read("text/names/first_male.txt"),"\n")
	first_names_female = splittext(rustg_file_read("text/names/first_female.txt"),"\n")
	last_names = splittext(rustg_file_read("text/names/last.txt"),"\n")

	adjectives = splittext(rustg_file_read("text/names/adjectives.txt"),"\n")
	verbs = splittext(rustg_file_read("text/names/verbs.txt"),"\n")
	wisdoms = splittext(rustg_file_read("text/names/wisdoms.txt"),"\n")

	first_codenames = splittext(rustg_file_read("text/names/codenames_first.txt"),"\n")
	last_codenames = splittext(rustg_file_read("text/names/codenames_last.txt"),"\n")

	log_subsystem(name,"Found [length(adjectives)] adjectives.")
	log_subsystem(name,"Found [length(verbs)] verbs.")
	log_subsystem(name,"Found [length(wisdoms)] verbs.")

	log_subsystem(name,"Found [length(first_names_male)] male first names.")
	log_subsystem(name,"Found [length(first_names_female)] female first names.")
	log_subsystem(name,"Found [length(last_names)] last names.")

	log_subsystem(name,"Found [length(first_codenames)] first codenames.")
	log_subsystem(name,"Found [length(last_codenames)] last codenames.")

	return ..()

/subsystem/text/proc/check_duplicate_name(var/name) //For mobs.
	if(name_count[name])
		name_count[name]++
		return "[name] ([name_count[name]])"
	name_count[name] = rand(1,999) //One funny thing is that you can tell at least how many of this type exists by starting it at 1, so it's random.
	return "[name] ([name_count[name]])"

/subsystem/text/proc/check_duplicate_player_name(var/name,var/ckey) //For players.
	var/length_of_duplicate_names = length(player_names[name])
	if(!length_of_duplicate_names)
		player_names[name] = list()
	if(!isnum(player_names[name][ckey]))
		player_names[name][ckey] = length_of_duplicate_names
	if(player_names[name][ckey] == 0)
		return name
	return "[name] the [player_names[name][ckey]]\th"

