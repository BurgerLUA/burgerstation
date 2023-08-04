/proc/get_value_text_for_debug(var/datum/D,var/key,var/value)

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


var/global/static/list/variable_names_to_ignore = list(
	"vars" = TRUE,
	"verbs" = TRUE,
	"loc" = TRUE,
	"vis_contents" = TRUE,
	"vis_locs" = TRUE,
	"contents" = TRUE
)

/proc/check_garbage(var/datum/needle)

	var/list/checked_refs = list()

	usr.to_chat(span("notice","Checking garbage in self..."))
	var/self_result = check_garbage_datum(needle,needle,checked_refs)
	if(self_result) usr.to_chat(span("notice","Found garbage! self -> [self_result]"))

	usr.to_chat(span("notice","Checking garbage in subsystems... ([length(checked_refs)] checked refs so far)"))
	for(var/k in all_subsystems)
		var/subsystem/S = k
		if(checked_refs["\ref[S]"])
			continue
		var/subsystem_result = check_garbage_datum(S,needle,checked_refs)
		if(subsystem_result)
			usr.to_chat(span("notice","Found garbage! Subsystems -> [subsystem_result]"))
		sleep(-1)

	usr.to_chat(span("notice","Checking garbage in world... ([length(checked_refs)] checked refs so far)"))
	for(var/datum/D in world)
		if(checked_refs["\ref[D]"])
			continue
		var/world_result = check_garbage_datum(D,needle,checked_refs)
		if(world_result)
			usr.to_chat(span("notice","Found garbage! world -> [world_result]"))
		sleep(-1)

	usr.to_chat(span("notice","Checked [length(checked_refs)] refs."))

/proc/check_garbage_list(var/list/haystack,var/datum/needle,var/list/checked_refs)

	checked_refs["\ref[haystack]"] = TRUE

	var/checked_ref_length = length(checked_refs)
	if(!(checked_ref_length % 1000))
		usr.to_chat(span("notice","...[checked_ref_length]..."))

	var/is_assoc = is_assoc_list(haystack)

	for(var/j in haystack)
		if(j == needle)
			return TRUE
		if(islist(j))
			if(checked_refs["\ref[j]"])
				continue
			var/result = check_garbage_list(j,needle,checked_refs)
			if(result)
				return "[haystack.type] -> [result]"
		else if(is_datum(j))
			if(checked_refs["\ref[j]"])
				continue
			var/result = check_garbage_datum(j,needle,checked_refs)
			if(result)
				return "[haystack.type] -> [result]"
		if(is_assoc)
			var/c = haystack[j]
			if(c == needle)
				return TRUE
			if(islist(c))
				if(checked_refs["\ref[c]"])
					continue
				var/result = check_garbage_list(c,needle,checked_refs)
				if(result)
					return "[haystack.type].[j] -> [result]"
			else if(is_datum(c))
				if(checked_refs["\ref[c]"])
					continue
				var/result = check_garbage_datum(c,needle,checked_refs)
				if(result)
					return "[haystack.type].[j] -> [result]"

		sleep(-1)

	return null


/proc/check_garbage_datum(var/datum/haystack,var/datum/needle,var/list/checked_refs)

	checked_refs["\ref[haystack]"] = TRUE

	var/checked_ref_length = length(checked_refs)
	if(!(checked_ref_length % 1000))
		log_debug(span("notice","...[checked_ref_length]..."))

	for(var/k in haystack.vars)
		var/v = haystack.vars[k]
		if(v == needle)
			return "[haystack.type].[k]"
		if(variable_names_to_ignore[k])
			continue
		if(islist(v))
			if(checked_refs["\ref[v]"])
				continue
			var/result = check_garbage_list(v,needle,checked_refs)
			if(result)
				return "[haystack.type].[k] -> [result]"
		else if(is_datum(v))
			if(checked_refs["\ref[v]"])
				continue
			var/result = check_garbage_datum(v,needle,checked_refs)
			if(result)
				return "[haystack.type].[k] -> [result]"
		sleep(-1)

	return null