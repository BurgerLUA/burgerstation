client/verb/var_edit(var/object as anything in view())
	set name = "Variable Edit"
	set category = "Debug"

	if(ckey != "burgerbb")
		to_chat("You cannot use this.")
		return FALSE

	if(!ENABLE_VAREDIT)
		to_chat("Varedit is disabled.")
		return FALSE

	if(!object)
		return FALSE

	if(is_datum(object))

		var/datum/D = object

		var/returning_text = "<br><center>[object]</center>"

		for(var/k in D.vars)

			if(k == "vars" || k == "verbs")
				continue

			var/v = D.vars[k]
			var/line_text = "[k] = [get_value_text_for_debug(D,k,v)]"
			returning_text += "[line_text]<br>"

		src << browse("<head><style>[STYLESHEET]</style></head><body style='font-size:75%'>[span("debug",returning_text)]</body>","window=help")



proc/get_value_text_for_debug(var/datum/D,var/key,var/value)

	if(!value)
		return "NULL"

	if(is_datum(value))
		var/datum/VD = value
		return "<a href=?var_edit_ref=\ref[VD]>[VD]</a> (<i>[VD.type]</i>)"

	if(is_list(value))

		if(length(value) == 0)
			return "list()"

		var/returning = "list(<br>"

		if(is_assoc_list(value))
			for(var/k in value)
				var/v = value["[k]"]
				returning += "&nbsp;[k] = [get_value_text_for_debug(v)]<br>"
		else
			var/index = 1
			for(var/v in value)
				returning += "&nbsp;[index] = [get_value_text_for_debug(null,null,v)]<br>"
				index++

		returning += ")"
		return returning

	if(!key)
		return value

	return "<a href=?var_edit_other=[key];var_edit_other_ref=\ref[D]>[value]</a>"


proc/is_assoc_list(var/list/L) //Credit to SpaceManiac for providing this

	if(!istype(L,/list/))
		return FALSE

	for(var/k in L)
		if (!isnum(k) && !isnull(L["[k]"]))
			return TRUE

	return FALSE

client/verb/change_variable(var/datum/object as anything in view(), var/desired_varable_key as text, var/desired_varable_value as anything)

	set name = "Change Variable"
	set category = "Debug"

	if(ckey != "burgerbb")
		to_chat("You cannot use this.")
		return FALSE

	if(!ENABLE_VAREDIT)
		to_chat("Varedit is disabled.")
		return FALSE

	if(desired_varable_value && istext(desired_varable_value))
		desired_varable_value = sanitize(desired_varable_value)

	if(object && is_datum(object) && desired_varable_key && desired_varable_value)
		object.vars[desired_varable_key] = desired_varable_value