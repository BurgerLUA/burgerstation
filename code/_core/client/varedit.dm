proc/get_value_text_for_debug(var/datum/D,var/key,var/value)

	if(is_datum(value))
		var/datum/VD = value
		return "<a href='?var_edit_ref=\ref[VD]'>[VD]</a> (<i>[VD.type]</i>)"

	if(islist(value))

		if(length(value) == 0)
			return "list()"

		var/returning = ""

		if(is_assoc_list(value))
			returning = "ASSOC_LIST(<br>"
			for(var/k in value)
				var/v = value["[k]"]
				returning += "&nbsp;[k] = [get_value_text_for_debug(value=v)]<br>"
		else
			returning = "LIST(<br>"
			var/index = 1
			for(var/v in value)
				returning += "&nbsp;[index] = [get_value_text_for_debug(value=v)]<br>"
				index++

		returning += ")"
		return returning

	if(!value && !isnum(value))
		value = "NULL"

	if(!key)
		return value

	return "<a href='?var_edit_other=[key];var_edit_other_ref=\ref[D]'>[value]</a>"