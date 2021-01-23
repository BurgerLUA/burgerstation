/proc/type_debug(var/x)

	if(ispath(x))
		return "[x] (PATH)"
	if(isnum(x))
		return "[x] (NUM)"
	if(istext(x))
		return "[x] (TEXT)"
	if(islist(x))
		if(is_assoc_list(x))
			return "list([length(x)]) (ASSOC LIST)"
		else
			return "list([length(x)]) (LIST)"
	if(is_datum(x))
		var/datum/D = x
		return D.get_debug_name()

	return "[x] (UNKNOWN)"