SUBSYSTEM_DEF(dialogue)
	name = "Dialogue Subsystem"
	desc = "Stores all the known dialogue in a list."
	priority = SS_ORDER_PRELOAD
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
		all_combat_dialogue[CD.type] = CD
		src.setup_combat_dialogue(CD)

	log_subsystem(name,"Initialized [length(all_combat_dialogue)] sets of combat dialogue.")


	return ..()



/subsystem/dialogue/proc/setup_combat_dialogue(var/combat_dialogue/CD)

	var/list/files = flist(CD.folderpath)

	if(!length(files))
		log_error("[CD.get_debug_name()] found no valid files in directory [CD.folderpath]!")
		return FALSE

	var/lines_of_dialogue = 0
	var/categories_of_dialogue = 0
	for(var/k in files)
		if(!has_suffix(k,".txt"))
			continue
		var/file_data = file2text("[CD.folderpath]/[k]")
		if(!file_data)
			continue
		var/file_name = get_filename(k)
		file_name = replacetext(file_name,".txt","")
		var/list/file_data_list = splittext(file_data,"\n")
		CD.dialogue_data[file_name] = list()
		categories_of_dialogue++
		for(var/line_text in file_data_list)
			if(!line_text)
				continue
			CD.dialogue_data[file_name] += line_text
			lines_of_dialogue++

	log_subsystem(src.name,"Initialized and found [categories_of_dialogue] categories of dialogue with [lines_of_dialogue] total lines for [CD.type].")


/subsystem/dialogue/proc/get_combat_dialogue(var/combat_dialogue/cd_id,var/desired_category,var/swear_chance=25)

	if(!desired_category)
		return FALSE

	var/combat_dialogue/CD = src.all_combat_dialogue[cd_id]
	if(!CD)
		log_error("Error: Could not find valid combat dialogue id [cd_id]!")
		return FALSE

	if(!CD.dialogue_data[desired_category])
		return FALSE

	if(prob(swear_chance))
		. = "[pick(CD.dialogue_data["swearing"])]"
		if(swear_chance >= 50)
			. += "! [capitalize(pick(CD.dialogue_data[desired_category]))]"
		else
			. += ", [pick(CD.dialogue_data[desired_category])]"

	if(swear_chance >= 90)
		. = uppertext(.)
	else
		. = capitalize(.)

	. = periodize(.)






