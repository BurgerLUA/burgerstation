SUBSYSTEM_DEF(lighting)
	name = "Lighting Subsystem"
	desc = "Controls lighting."
	tick_rate = DECISECONDS_TO_TICKS(LIGHTING_INTERVAL)
	priority = SS_ORDER_LIGHTING

	var/total_lighting_overlays = 0
	var/total_lighting_sources = 0
	var/list/lighting_corners = list()	// List of all lighting corners in the world.

	var/list/light_queue   = list() // lighting sources  queued for update.
	var/lq_idex = 1
	var/list/corner_queue  = list() // lighting corners  queued for update.
	var/cq_idex = 1
	var/list/overlay_queue = list() // lighting overlays queued for update.
	var/oq_idex = 1

	var/tmp/processed_lights = 0
	var/tmp/processed_corners = 0
	var/tmp/processed_overlays = 0

	var/total_ss_updates = 0
	var/total_instant_updates = 0

	tick_usage_max = 75
	cpu_usage_max = 75

/subsystem/lighting/unclog(var/mob/caller)

	for(var/k in lighting_corners)
		var/datum/D = k
		lighting_corners -= k
		qdel(D)

	broadcast_to_clients(span("danger","Removed all lighting corners."))

	return ..()

#ifdef USE_INTELLIGENT_LIGHTING_UPDATES
	var/force_queued = TRUE
	var/force_override = FALSE	// For admins.
#endif

/subsystem/lighting/Initialize()

	if(ENABLE_LIGHTING)

		log_debug("Initializing lighting... this may take a while...")

		var/overlay_count = 0

		for(var/zlevel = 1 to world.maxz)
			overlay_count += CreateLobjForZ(zlevel)

		on_life()

		log_subsystem(name,"Initialized [processed_lights] lights.")
		log_subsystem(name,"Initialized [processed_corners] corners.")
		log_subsystem(name,"Initialized [processed_overlays] overlays.")

		initialized = TRUE

	return TRUE


#ifdef USE_INTELLIGENT_LIGHTING_UPDATES
/subsystem/lighting/proc/handle_roundstart()
	force_queued = FALSE
	total_ss_updates = 0
	total_instant_updates = 0

#endif



/subsystem/lighting/proc/CreateLobjForZ(zlevel)
	. = 0
	for (var/thing in Z_ALL_TURFS(zlevel))
		CHECK_TICK(tick_usage_max,0)
		var/turf/T = thing
		if(TURF_IS_DYNAMICALLY_LIT_UNSAFE(T))
			new /atom/movable/lighting_overlay(T)
			. += 1


/subsystem/lighting/proc/InitializeLightingAtoms(list/atoms)
	. = 0
	for (var/turf/T in atoms)
		CHECK_TICK(tick_usage_max,0)
		if (TURF_IS_DYNAMICALLY_LIT_UNSAFE(T))
			new /atom/movable/lighting_overlay(T)
			. += 1

/subsystem/lighting/on_life()

	if(!ENABLE_LIGHTING)
		return TRUE

	var/list/curr_lights = light_queue
	var/list/curr_corners = corner_queue
	var/list/curr_overlays = overlay_queue

	if(lq_idex <= 0)
		log_error("Lighting Error: lq_idex is at [lq_idex].")

	while (length(curr_lights) && lq_idex <= length(curr_lights))
		CHECK_TICK(tick_usage_max,0)
		var/light_source/L = curr_lights[lq_idex]
		if (L.needs_update != LIGHTING_NO_UPDATE)
			total_ss_updates += 1
			L.update_corners()
			L.needs_update = LIGHTING_NO_UPDATE
			processed_lights++
		lq_idex++

	if (lq_idex > 1)
		if(length(curr_lights))
			curr_lights.Cut(1, lq_idex)
		lq_idex = 1

	if(cq_idex <= 0)
		log_error("Lighting Error: cq_idex is at [cq_idex].")

	while (length(curr_corners) && cq_idex <= length(curr_corners))
		CHECK_TICK(tick_usage_max,0)
		var/lighting_corner/C = curr_corners[cq_idex]
		if (C.needs_update)
			C.update_lighting_overlays()
			C.needs_update = FALSE
			processed_corners++
		cq_idex++

	if (cq_idex > 1)
		if(length(curr_corners))
			curr_corners.Cut(1, cq_idex)
		cq_idex = 1

	if(oq_idex <= 0)
		log_error("Lighting Error: oq_idex is at [oq_idex].")

	while (length(curr_overlays) && oq_idex <= length(curr_overlays))
		CHECK_TICK(tick_usage_max,0)
		if(oq_idex < 0 || oq_idex > length(curr_overlays))
			log_error("Lighting Error: List index out of bounds! Data: [length(curr_overlays)], [oq_idex].")
			break
		var/atom/movable/lighting_overlay/O = curr_overlays[oq_idex]
		if (!O.qdeleting && O.needs_update)
			O.update_overlays()
			O.needs_update = FALSE
			processed_overlays++
		oq_idex++

	if (oq_idex > 1)
		if(length(curr_overlays))
			curr_overlays.Cut(1, oq_idex)
		oq_idex = 1

	return TRUE