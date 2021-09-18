/proc/text2path_safe(var/path_as_text,var/extra_check)
	var/first = TRUE
	while(TRUE)
		var/result = text2path(path_as_text)
		if(result)
			if(!first && extra_check)
				var/call_result = call(extra_check)(result)
				if(call_result == null)
					return null
				else if(call_result == FALSE)
					continue
			return result
		var/last_position = findlasttext(path_as_text,"/")
		if(!last_position)
			return null
		path_as_text = copytext(path_as_text,1,last_position)
		if(length(path_as_text) <= 1)
			return null
		first = FALSE

/proc/ec_valid_item(var/obj/item/I)
	if(initial(I.value) < 0)
		return null
	return TRUE