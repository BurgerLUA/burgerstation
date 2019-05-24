var/global/list/name_count = list()

proc/check_duplicate_name(var/name)
	if(name_count[name])
		name_count[name]++
		return "[name]([name_count[name]])"
	else
		name_count[name] = 1
		return name