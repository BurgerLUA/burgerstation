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


