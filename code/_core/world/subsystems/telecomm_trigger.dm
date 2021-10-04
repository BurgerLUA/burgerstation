SUBSYSTEM_DEF(telecomm_trigger)
	name = "Telecomm Trigger Subsystem"
	desc = "Manages trigger words for people spying on comms."
	priority = SS_ORDER_LAST

	var/telecomm_trigger/stored_trigger

/subsystem/telecomm_trigger/Initialize()

	var/list/possible_triggers = subtypesof(/telecomm_trigger/)
	var/telecomm_trigger/T = pick(possible_triggers)
	T = new T
	if(T.selected_trigger_name && T.selected_trigger_regex)
		stored_trigger = T
		log_subsystem(src.name,"Loaded telecomm trigger [T.name] with trigger type of [T.selected_trigger_name].")
	else
		log_subsystem(src.name,"Could not find a valid telecomm trigger to load.")
	. = ..()