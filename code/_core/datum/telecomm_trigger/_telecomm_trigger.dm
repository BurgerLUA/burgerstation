/telecomm_trigger/
	var/name = "America"
	var/trigger_file //The json file of the trigger.

	var/selected_trigger_name
	var/regex/selected_trigger_regex

/telecomm_trigger/proc/check_trigger(var/text_to_search)
	return selected_trigger_regex.Find(text_to_search)

/telecomm_trigger/proc/trigger()
	return TRUE

/telecomm_trigger/america
	name = "Space America Invasion"
	trigger_file = "data/server/telecomm_trigger/america.json"

/telecomm_trigger/america/New()
	. = ..()

	if(!trigger_file)
		log_error("Warning: Trigger file [src.type] didn't have a valid trigger_file!")
		return

	var/loaded_data = rustg_file_read(trigger_file)
	if(!loaded_data)
		log_error("Warning: Couldn't load [src.type] as file [trigger_file] was not found!")
		return

	var/list/loaded_list = json_decode(loaded_data)
	if(!length(loaded_list))
		log_error("Warning: Couldn't load [src.type] as file [trigger_file] was an invalid json file!")
		return

	selected_trigger_name = pick(loaded_list)

	if(!loaded_list[selected_trigger_name])
		log_error("Warning: Couldn't load [src.type] as file [trigger_file] had an incorrect json format!")
		return

	selected_trigger_regex = regex(loaded_list[selected_trigger_name])

/telecomm_trigger/america/trigger()
	. = ..()
	announce(
		"Incoming Message from the American Space Federation",
		"Declaration of Freedom",
		"Did someone say [selected_trigger_name]? We're coming to spread democracy in the area. Do not resist. God bless Space America.",
		sound_to_play = 'sound/voice/announcement/america_invade.ogg'
	)
