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
		if(found_datum && found_datum.type == o_type)
			if(!ref_id_to_warning[ref_id])
				ref_id_to_warning[ref_id] = 1
			else
				ref_id_to_warning[ref_id] += 1
		else
			ref_id_to_warning -= ref_id
			qdel_refs_to_type -= ref_id

	for(var/ref_id in ref_id_to_warning)
		if(ref_id_to_warning[ref_id] == 3)
			var/datum/undeleted_object = locate(ref_id)
			if(undeleted_object)
				LOG_DEBUG("Warning: [undeleted_object.name]([undeleted_object.type]) with refid of [ref_id] has been suspected of being in the garbage system for more than 3 minutes!")
			else
				ref_id_to_warning -= ref_id
				qdel_refs_to_type -= ref_id

	return TRUE

client/verb/print_garbage()

	/*
	if(!length(qdel_refs_to_type))
		to_chat("Nothing has been found in the garbage warning and tracking system.")
		return TRUE

	var/final_text_1 = ""

	for(var/ref_id in qdel_refs_to_type)
		var/o_type = qdel_refs_to_type[ref_id]
		final_text_1 += "[ref_id]([o_type])"

	to_chat(final_text_1)
	*/

	if(!length(ref_id_to_warning))
		to_chat("Nothing has been found in the garbage warning system.")
		return TRUE

	var/final_text_2 = ""

	for(var/ref_id in ref_id_to_warning)
		var/warning_count = ref_id_to_warning[ref_id]
		var/o_type = qdel_refs_to_type[ref_id]
		final_text_2 += "[ref_id]([o_type]) = [warning_count]<br>"

	to_chat(final_text_2)
