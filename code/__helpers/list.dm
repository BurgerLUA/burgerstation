/proc/debug_list(list/L)
	for(var/k in L)
		var/v = L[k]
		log_debug("[k]: [v]")


