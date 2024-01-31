#define ERROR_DIR "error_log.txt"
#define RENAME_DIR "data/server/rename_log.txt"


/proc/print_list(list_name,list/L)
	log_debug("Printing list '[list_name]' of length [length(L)]:")
	for(var/i=1,i<=length(L),i++)
		log_debug("[i]: [L[i]]")

/proc/print_assoc_list(list_name,list/L)
	log_debug("Printing list '[list_name]' of length [length(L)]:")
	var/i=1
	for(var/k in L)
		var/v = L[k]
		if(v != null)
			log_debug("[k]: [v]")
		else
			log_debug("[i]: [k]")
		i++

/proc/print_list_dir(list_name,list/L)
	log_debug("Printing direction list '[list_name]' of length [length(L)]:")
	for(var/k in L)
		var/v = L[k]
		log_debug("[dir2text(text2num(k))]: [v]")

/proc/log_subsystem(subsystem_name,log_text)
	if(SSconfig?.initialized && !CONFIG("ENABLE_LOGGING",TRUE))
		return FALSE
	world_log("<span class='subsystem'><b>[subsystem_name]</b>: [log_text]</span>")
	SSlogging.buffered_log_subsystem += "[subsystem_name]: [log_text]"

/proc/log_error(log_text)
	if(SSconfig?.initialized && !CONFIG("ENABLE_LOGGING",TRUE))
		return FALSE
	world_log("<span class='error'>[log_text]</span>")
	SSlogging.buffered_log_error += log_text

var/global/list/all_error_ids = list()

/proc/log_error_once(log_id,log_text)
	if(SSconfig?.initialized && !CONFIG("ENABLE_LOGGING",TRUE))
		return FALSE
	if(!log_text)
		log_text = log_id
	if(all_error_ids[log_id])
		return FALSE
	all_error_ids[log_id] = TRUE
	world_log("<span class='error'>[log_text]</span>")
	SSlogging.buffered_log_error += log_text

/proc/log_debug(log_text)
	if(SSconfig?.initialized && !CONFIG("ENABLE_LOGGING",TRUE))
		return FALSE
	world_log("<span class='debug'>[log_text]</span>")
	SSlogging.buffered_log_debug += log_text

/proc/log_admin(log_text)
	if(SSconfig?.initialized && !CONFIG("ENABLE_LOGGING",TRUE))
		return FALSE
	world_log("<span class='admin'>[log_text]</span>")
	SSlogging.buffered_log_admin += log_text

/proc/log_chat(log_text)
	if(SSconfig?.initialized && !CONFIG("ENABLE_LOGGING",TRUE))
		return FALSE
	SSlogging.buffered_log_chat += log_text

/proc/world_log(log_text)
	if(SSconfig?.initialized && !CONFIG("ENABLE_LOGGING",TRUE))
		return FALSE
	world.log << log_text
