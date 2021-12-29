/telecomm_trigger/
	var/name = "America"
	var/trigger_file //The json file of the trigger.

	var/selected_trigger_name
	var/regex/selected_trigger_regex

/telecomm_trigger/proc/check_trigger(var/text_to_search)
	return selected_trigger_regex.Find(text_to_search)

/telecomm_trigger/proc/trigger()
	return TRUE