/proc/debug_list(var/list/L)
	for(var/k in L)
		var/v = L[k]
		log_debug("[k]: [v]")


