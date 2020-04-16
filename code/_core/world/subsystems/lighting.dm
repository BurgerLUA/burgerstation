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

#ifdef USE_INTELLIGENT_LIGHTING_UPDATES
	var/force_queued = TRUE
	var/force_override = FALSE	// For admins.
#endif

/subsystem/lighting/Initialize()

	if(ENABLE_LIGHTING)

		LOG_DEBUG("Initializing lighting... this may take a while...")

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
		CHECK_TICK
		var/turf/T = thing
		if(TURF_IS_DYNAMICALLY_LIT_UNSAFE(T))
			new /atom/movable/lighting_overlay(T)
			. += 1


/subsystem/lighting/proc/InitializeLightingAtoms(list/atoms)
	. = 0
	for (var/turf/T in atoms)
		CHECK_TICK
		if (TURF_IS_DYNAMICALLY_LIT_UNSAFE(T))
			new /atom/movable/lighting_overlay(T)
			. += 1

/subsystem/lighting/on_life()

	if(!ENABLE_LIGHTING)
		return TRUE

	spawn()
		var/list/curr_lights = light_queue
		var/list/curr_corners = corner_queue
		var/list/curr_overlays = overlay_queue

		while (lq_idex <= curr_lights.len)
			CHECK_TICK
			var/light_source/L = curr_lights[lq_idex++]
			if (L.needs_update != LIGHTING_NO_UPDATE)
				total_ss_updates += 1
				L.update_corners()
				L.needs_update = LIGHTING_NO_UPDATE
				processed_lights++

		if (lq_idex > 1)
			curr_lights.Cut(1, lq_idex)
			lq_idex = 1

		while (cq_idex <= curr_corners.len)
			CHECK_TICK
			var/lighting_corner/C = curr_corners[cq_idex++]
			if (C.needs_update)
				C.update_overlays()
				C.needs_update = FALSE
				processed_corners++

		if (cq_idex > 1)
			curr_corners.Cut(1, cq_idex)
			cq_idex = 1

		while (oq_idex <= curr_overlays.len)
			CHECK_TICK
			var/atom/movable/lighting_overlay/O = curr_overlays[oq_idex++]
			if (!O.qdeleting && O.needs_update)
				O.update_overlays()
				O.needs_update = FALSE
				processed_overlays++

		if (oq_idex > 1)
			curr_overlays.Cut(1, oq_idex)
			oq_idex = 1

	return TRUE