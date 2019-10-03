client/verb/var_edit(var/object as anything in view())
	set name = "Variable Edit"
	set category = "Debug"

	if(!object)
		return FALSE

	if(is_datum(object))

		var/datum/D = object

		var/returning_text = "<br><center>[object]</center>"

		for(var/k in D.vars)
			var/v = D.vars[k]

			var/line_text = "[k] = "
			if(!v)
				line_text += "NULL"
			else if(is_datum(v))
				line_text += "<a href=?var_edit_ref=\ref[v]>[v]</a>"
			else if(is_list(v))
				line_text += "<a href=?var_edit_list='no'>list()</a>"
			else
				line_text += "<a href=?var_edit_other=[k];var_edit_other_ref=\ref[D]>[v]</a>"

			returning_text += "[line_text]<br>"

		src << browse(returning_text,"window=help")

client/verb/change_variable(var/datum/object as anything in view(), var/desired_varable_key as text, var/desired_varable_value as anything)

	set name = "Change Variable"
	set category = "Debug"

	if(desired_varable_value && istext(desired_varable_value))
		desired_varable_value = sanitize(desired_varable_value)

	if(object && is_datum(object) && desired_varable_key && desired_varable_value)
		object.vars[desired_varable_key] = desired_varable_value
		world.log << "[object]: set [desired_varable_key] to [desired_varable_value]."