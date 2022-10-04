SUBSYSTEM_DEF(ghost)
	name = "Ghost Subsystem"
	desc = "Controls ghost related stuff."
	priority = SS_ORDER_LAST
	tick_rate = SECONDS_TO_TICKS(1)

	tick_usage_max = 75

	var/list/obj/item/emf/all_emf_trackers = list()
	var/list/obj/emf/all_emfs = list()

/subsystem/ghost/unclog(var/mob/caller)

	for(var/k in all_emfs)
		var/datum/D = k
		all_emfs -= k
		qdel(D)

	broadcast_to_clients(span("danger","Removed all active EMFs."))

	return ..()

/subsystem/ghost/on_life()

	for(var/k in all_emf_trackers)
		var/obj/item/emf/E = k
		E.on_emf_think()
		CHECK_TICK_SAFE(tick_usage_max,FPS_SERVER)

	for(var/k in all_emfs)
		var/obj/emf/E = k
		if(E.time_to_delete <= world.time)
			qdel(E)
		CHECK_TICK_SAFE(tick_usage_max,FPS_SERVER)

	return TRUE