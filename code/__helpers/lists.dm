/proc/subtypesof(prototype)
	return (typesof(prototype) - prototype)

/proc/listclearnulls(list/L)
	var/start_len = L.len
	var/list/N = new(start_len)
	L -= N
	return L.len < start_len

/proc/english_list(var/list/input, nothing_text = "nothing", and_text = " and ", comma_text = ", ", final_comma_text = "", quote = "" )
	var/total = input.len
	if (!total)
		return "[nothing_text]"
	else if (total == 1)
		return "[quote][input[1]][quote]"
	else if (total == 2)
		return "[quote][input[1]][quote][and_text][quote][input[2]][quote]"
	else
		var/output = ""
		var/index = 1
		while (index < total)
			if (index == total - 1)
				comma_text = final_comma_text

			output += "[quote][input[index]][quote][comma_text]"
			index++

		return "[output][and_text][quote][input[index]][quote]"


#define value_or_null(the_list,key) the_list[key] ? the_list[key] : null