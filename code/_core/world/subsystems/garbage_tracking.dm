var/global/list/ref_id_to_warning = list()

#define GARBAGE_TIME_WARNING 300 //Time in seconds, to alert the server that an object is having difficulty being deleted.

SUBSYSTEM_DEF(garbage_tracking)
	name = "Garbage Tracking Subsystem"
	desc = "Powered by raw shitcode."
	priority = SS_ORDER_FIRST
	tick_rate = SECONDS_TO_TICKS(60)
	tick_usage_max = 75
	cpu_usage_max = 75

/subsystem/garbage_tracking/Initialize()
	fdel(GARBAGE_LOGS_PATH)
	return ..()

/subsystem/garbage_tracking/on_life()

	for(var/ref_id in qdel_refs_to_type)
		CHECK_TICK(tick_usage_max,0)
		var/o_type = qdel_refs_to_type[ref_id]
		var/datum/found_datum = locate(ref_id)
		if(found_datum && found_datum.type == o_type && found_datum.qdeleting)
			if(!ref_id_to_warning[ref_id])
				ref_id_to_warning[ref_id] = TICKS_TO_SECONDS(tick_rate)
			else
				ref_id_to_warning[ref_id] += TICKS_TO_SECONDS(tick_rate)

			if(!found_datum.qdel_warning_time && ref_id_to_warning[ref_id] >= GARBAGE_TIME_WARNING)
				text2file("[found_datum.get_debug_name()] is taking more than [GARBAGE_TIME_WARNING] seconds to delete!",GARBAGE_LOGS_PATH)
				found_datum.qdel_warning_time = TRUE
				ref_id_to_warning -= ref_id
				qdel_refs_to_type -= ref_id
		else
			ref_id_to_warning -= ref_id
			qdel_refs_to_type -= ref_id



	return TRUE


