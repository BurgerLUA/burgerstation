SUBSYSTEM_DEF(dialogue)
	name = "Dialogue Subsystem"
	desc = "Stores all the known dialogue in a list."
	priority = SS_ORDER_FIRST
	var/list/all_dialogue = list()
	var/list/all_combat_dialogue = list()

/subsystem/dialogue/Initialize()

	for(var/A in subtypesof(/dialogue/))
		var/dialogue/D = new A
		all_dialogue[D.type] = D

	log_subsystem(name,"Initialized [length(all_dialogue)] sets of regular dialogue.")

	for(var/A in subtypesof(/combat_dialogue/))
		var/combat_dialogue/CD = A
		if(!initial(CD.folderpath))
			continue
		CD = new A
		if(!src.setup_combat_dialogue(CD))
			continue
		all_combat_dialogue[CD.type] = CD

	log_subsystem(name,"Initialized [length(all_combat_dialogue)] sets of combat dialogue.")


	return ..()



/subsystem/dialogue/proc/setup_combat_dialogue(var/combat_dialogue/CD)

	var/list/files = flist("[CD.folderpath]/")

	if(!length(files))
		log_error("[CD.get_debug_name()] found no valid files in directory [CD.folderpath]!")
		return FALSE

	var/lines_of_dialogue = 0
	var/categories_of_dialogue = 0
	for(var/k in files)
		if(!has_suffix(k,".txt"))
			continue
		var/file_data = rustg_file_read("[CD.folderpath]/[k]")
		if(!file_data)
			continue
		var/file_name = replacetext(k,".txt","")
		var/list/file_data_list = splittext(file_data,"\n")
		CD.dialogue_data[file_name] = list()
		categories_of_dialogue++
		for(var/line_text in file_data_list)
			if(!line_text)
				continue
			CD.dialogue_data[file_name] += line_text
			lines_of_dialogue++

	log_subsystem(src.name,"Initialized and found [categories_of_dialogue] categories of dialogue with [lines_of_dialogue] total lines for [CD.type].")

	return TRUE

/subsystem/dialogue/proc/get_combat_dialogue(var/combat_dialogue/cd_id,var/desired_category,var/swear_chance=25)

	if(!desired_category)
		return FALSE

	var/combat_dialogue/CD = src.all_combat_dialogue[cd_id]
	if(!CD)
		return FALSE

	if(!CD.dialogue_data[desired_category])
		return FALSE

	var/dialogue_to_use

	if(CD.used_dialogue && CD.used_dialogue[desired_category])
		var/list/usable_dialogue = CD.dialogue_data[desired_category].Copy()
		usable_dialogue -= CD.used_dialogue[desired_category]
		if(!length(usable_dialogue)) //Empty!
			CD.used_dialogue[desired_category] = list()
			usable_dialogue = CD.dialogue_data[desired_category]
		dialogue_to_use = pick(usable_dialogue)
		CD.used_dialogue[desired_category] += dialogue_to_use
	else
		if(!CD.used_dialogue)
			CD.used_dialogue = list()
		dialogue_to_use = pick(CD.dialogue_data[desired_category])
		CD.used_dialogue[desired_category] = list(dialogue_to_use)


	if(prob(swear_chance))
		. = "[pick(CD.dialogue_data["swearing"])]"
		if(swear_chance >= 50)
			. += "! [capitalize(dialogue_to_use)]"
		else
			. += ", [pick(dialogue_to_use)]"
	else
		. = pick(dialogue_to_use)

	if(swear_chance >= 90)
		. = uppertext(.)
	else
		. = capitalize(.)

	. = periodize(.)






