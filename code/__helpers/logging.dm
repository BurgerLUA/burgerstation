#define ERROR_DIR "error_log.txt"
#define RENAME_DIR "data/server/rename_log.txt"


/proc/print_list(var/list_name,var/list/L)
	log_debug("Printing list '[list_name]' of length [length(L)]:")
	for(var/i=1,i<=length(L),i++)
		log_debug("[i]: [L[i]]")

/proc/print_assoc_list(var/list_name,var/list/L)
	log_debug("Printing list '[list_name]' of length [length(L)]:")
	var/i=1
	for(var/k in L)
		var/v = L[k]
		if(v != null)
			log_debug("[k]: [v]")
		else
			log_debug("[i]: [k]")
		i++

/proc/print_list_dir(var/list_name,var/list/L)
	log_debug("Printing direction list '[list_name]' of length [length(L)]:")
	for(var/k in L)
		var/v = L[k]
		log_debug("[dir2text(text2num(k))]: [v]")


//Completed
/proc/log_subsystem(var/subsystem_name,var/log_text)
	world_log("<span class='subsystem'><b>[subsystem_name]</b>: [log_text]</span>")
	SSlogging.buffered_log_debug += "[subsystem_name]: [log_text]"
	SSlogging.buffered_log_admin += "[subsystem_name]: [log_text]"

/proc/log_error(var/log_text)
	world_log("<span class='error'>[log_text]</span>")
	SSlogging.buffered_log_error += log_text

/proc/log_debug(var/log_text)
	world_log("<span class='debug'>[log_text]</span>")
	SSlogging.buffered_log_debug += log_text

/proc/log_admin(var/log_text)
	world_log("<span class='admin'>[log_text]</span>")
	SSlogging.buffered_log_admin += log_text

/proc/log_chat(var/log_text)
	SSlogging.buffered_log_chat += log_text


/proc/world_log(var/log_text)
	world.log << log_text