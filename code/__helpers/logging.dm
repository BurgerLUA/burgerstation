/proc/log_error(var/log_text)
 	world.log << "<span class='error'>[log_text]</span>"

/proc/log_subsystem(var/subsystem_id,var/log_text)
	world.log << "<span class='subsystem'><b><u>[subsystem_id]:</u></b> [log_text]</span>"

/proc/log_unit_test(var/subsystem_id,var/log_text)
	world.log << "<span class='unittest'><b><u>[subsystem_id]:</u></b> [log_text]</span>"

/proc/print_list(var/list_name,var/list/L)
	LOG_DEBUG("Printing list '[list_name]' of length [length(L)]:")
	for(var/i=1,i<=length(L),i++)
		LOG_DEBUG("[i]: [L[i]]")

/proc/print_assoc_list(var/list_name,var/list/L)
	LOG_DEBUG("Printing list '[list_name]' of length [length(L)]:")
	var/i=1
	for(var/k in L)
		var/v = L[k]
		if(v != null)
			LOG_DEBUG("[k]: [v]")
		else
			LOG_DEBUG("[i]: [k]")
		i++

/proc/print_list_dir(var/list_name,var/list/L)
	LOG_DEBUG("Printing direction list '[list_name]' of length [length(L)]:")
	for(var/k in L)
		var/v = L[k]
		LOG_DEBUG("[dir2text(text2num(k))]: [v]")