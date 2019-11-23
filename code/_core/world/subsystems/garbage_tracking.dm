var/list/ref_id_to_warning = list()

/subsystem/garbage_tracking/
	name = "Garbage Subsystem"
	desc = "Powered by raw shitcode."
	priority = SS_ORDER_PRELOAD
	tick_rate = SECONDS_TO_TICKS(10)

/subsystem/garbage_tracking/on_life()

	for(var/ref_id in qdel_refs_to_type)

		var/o_type = qdel_refs_to_type[ref_id]

		var/datum/found_datum = locate(ref_id)
		if(found_datum && found_datum.type == o_type && found_datum.qdeleting)
			if(!ref_id_to_warning[ref_id])
				ref_id_to_warning[ref_id] = TICKS_TO_SECONDS(tick_rate)
			else
				ref_id_to_warning[ref_id] += TICKS_TO_SECONDS(tick_rate)
		else
			ref_id_to_warning -= ref_id
			qdel_refs_to_type -= ref_id

	return TRUE

/*
client/verb/print_garbage()

	if(!length(ref_id_to_warning))
		to_chat("Nothing has been found in the garbage warning system.")
		return TRUE

	var/final_text = "<h1>Found [length(ref_id_to_warning)] objects that refuse to be deleted.</h1>"

	for(var/ref_id in ref_id_to_warning)
		var/warning_count = ref_id_to_warning[ref_id]
		var/o_type = qdel_refs_to_type[ref_id]
		var/var_edit_text = "<a href=?var_edit_ref=[ref_id]>[ref_id]</a>"
		final_text += "<br>[var_edit_text]([o_type]) = ~[warning_count] seconds"

	src << browse("<head><style>[STYLESHEET]</style></head><body>[final_text]</body>","window=garbage")
*/