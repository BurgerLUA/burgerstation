#define RANK_DIR "data/server/rank.txt"

SUBSYSTEM_DEF(admin)
	name = "Admin Management"
	desc = "Handles admin management and what verbs players get."
	priority = SS_ORDER_PRELOAD
	var/list/stored_ranks = list()
	var/list/stored_user_ranks = list()

/subsystem/admin/Initialize()

	for(var/k in subtypesof(/rank/))
		var/rank/R = new k
		stored_ranks[lowertext(R.id)] = R
	log_subsystem(src.name,"Loaded [length(stored_ranks)] different ranks.")

	if(!fexists(RANK_DIR))
		log_subsystem(name,"Could not find an admin file ([RANK_DIR]).")
		return ..()

	var/file_text = file2text(RANK_DIR)
	var/list/split_file = splittext(file_text,"\n")
	var/line_count = 0
	for(var/line in split_file)
		line_count++
		if(copytext(line,1,2) == "#")
			continue
		var/list/split_line = splittext(line," ")
		if(length(split_line) < 2)
			log_error("Invalid rank format for [RANK_DIR] on line [line_count]: [line]")
			continue
		var/ckey = lowertext(split_line[1])
		var/list/rank_ids = split_line.Copy(2)
		for(var/rank in rank_ids)
			rank = lowertext(rank)
			if(!stored_ranks[rank])
				log_error("Rank [rank] not found for [RANK_DIR] on line [line_count]!")
				continue
			var/rank/R = stored_ranks[rank]
			if(!stored_user_ranks[ckey])
				stored_user_ranks[ckey] = list()
			stored_user_ranks[ckey] |= R
			log_subsystem(src.name,"Added rank [R.name] for ckey [ckey].")

	log_subsystem(src.name,"Loaded [length(stored_user_ranks)] users with special permissions.")

	update_permissions()

	return ..()

/subsystem/admin/proc/update_permissions()
	for(var/k in all_clients)
		var/client/C = all_clients[k]
		C.sync_permissions()
	return TRUE


