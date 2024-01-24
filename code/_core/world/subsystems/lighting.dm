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

	var/debug_light_sources = FALSE
	var/list/light_source_atom_count

	/var/lighting_corner/dummy/dummy_lighting_corner = new
	// Because we can control each corner of every lighting overlay.
	// And corners get shared between multiple turfs (unless you're on the corners of the map, then 1 corner doesn't).
	// For the record: these should never ever ever be deleted, even if the turf doesn't have dynamic lighting.

	// This list is what the code that assigns corners listens to, the order in this list is the order in which corners are added to the /turf/corners list.
	/var/list/LIGHTING_CORNER_DIAGONAL = list(NORTHEAST, SOUTHEAST, SOUTHWEST, NORTHWEST)

	// This is the reverse of the above - the position in the array is a dir. Update this if the above changes.
	var/list/REVERSE_LIGHTING_CORNER_DIAGONAL = list(0, 0, 0, 0, 3, 4, 0, 0, 2, 1)


/subsystem/lighting/proc/start_debug()
	if(CALLBACK_EXISTS("lighting_debug_end"))
		return FALSE
	debug_light_sources = TRUE
	light_source_atom_count = list()
	CALLBACK("lighting_debug_end",30 SECONDS,src,src::end_debug())
	log_debug("Debugging lighting... please wait 30 seconds.")
	return TRUE

/subsystem/lighting/proc/end_debug()

	sort_tim(light_source_atom_count,/proc/cmp_numeric_dsc,associative=TRUE)

	log_debug("<b><u>Top 5 most frequent light sources (by type)</u></b>")

	for(var/i=1,i<=min(5,length(light_source_atom_count)),i++)
		log_debug("#[i]: [light_source_atom_count[i]] ([light_source_atom_count[light_source_atom_count[i]]])")

	debug_light_sources = FALSE
	light_source_atom_count.Cut()

	return TRUE



/subsystem/lighting/unclog(var/mob/caller)

	for(var/k in lighting_corners)
		var/datum/D = k
		lighting_corners -= k
		if(!D || D.qdeleting)
			continue
		qdel(D)

	. = ..()

/subsystem/lighting/Initialize()

	set background = TRUE

	if(!CONFIG("ENABLE_LIGHTING",TRUE))
		active_subsystems -= src
		return TRUE

	log_subsystem(name,"Initializing lighting... this may take a while...")

	for(var/turf/simulated/S in world)
		if(!S.dynamic_lighting)
			continue
		var/area/A = S.loc
		if(!A.dynamic_lighting)
			continue
		new /atom/movable/lighting_overlay(S)
		CHECK_TICK_HARD

	var/first = TRUE
	while(first || (length(light_queue) && length(corner_queue) && length(overlay_queue)))
		update_lights()
		update_corners()
		update_overlays()
		first = FALSE
		CHECK_TICK_HARD

	log_subsystem(name,"Initialized [processed_lights] lights.")
	log_subsystem(name,"Initialized [processed_corners] corners.")
	log_subsystem(name,"Initialized [processed_overlays] overlays.")

	return TRUE


/subsystem/lighting/proc/update_lights()

	var/list/curr_lights = light_queue

	if(lq_idex <= 0)
		log_error("Lighting Error: lq_idex is at [lq_idex].")

	while (length(curr_lights) && lq_idex <= length(curr_lights))
		var/light_source/L = curr_lights[lq_idex]
		if(L.needs_update != LIGHTING_NO_UPDATE)
			total_ss_updates += 1
			L.update_corners()
			L.needs_update = LIGHTING_NO_UPDATE
			if(debug_light_sources && L.source_atom && L.source_atom.type)
				if(!light_source_atom_count[L.source_atom.type])
					light_source_atom_count[L.source_atom.type] = 1
				else
					light_source_atom_count[L.source_atom.type] += 1
			processed_lights++
		lq_idex++
		CHECK_TICK(tick_usage_max,FPS_SERVER)

	if (lq_idex > 1)
		if(length(curr_lights))
			curr_lights.Cut(1, lq_idex)
		lq_idex = 1

	if(cq_idex <= 0)
		log_error("Lighting Error: cq_idex is at [cq_idex].")


/subsystem/lighting/proc/update_corners()

	var/list/curr_corners = corner_queue

	while (length(curr_corners) && cq_idex <= length(curr_corners))
		var/lighting_corner/C = curr_corners[cq_idex]
		if(C.needs_update != LIGHTING_NO_UPDATE)
			C.update_lighting_overlays()
			C.needs_update = LIGHTING_NO_UPDATE
			processed_corners++
		cq_idex++
		CHECK_TICK(tick_usage_max,FPS_SERVER)

	if (cq_idex > 1)
		if(length(curr_corners))
			curr_corners.Cut(1, cq_idex)
		cq_idex = 1


/subsystem/lighting/proc/update_overlays()

	var/list/curr_overlays = overlay_queue

	if(oq_idex <= 0)
		log_error("Lighting Error: oq_idex is at [oq_idex].")

	while (length(curr_overlays) && oq_idex <= length(curr_overlays))
		if(oq_idex < 0 || oq_idex > length(curr_overlays))
			log_error("Lighting Error: List index out of bounds! Data: [length(curr_overlays)], [oq_idex].")
			break
		var/atom/movable/lighting_overlay/O = curr_overlays[oq_idex]
		if (!O.qdeleting && O.needs_update != LIGHTING_NO_UPDATE)
			O.update_overlays()
			O.needs_update = FALSE
			processed_overlays++
		oq_idex++
		CHECK_TICK(tick_usage_max,FPS_SERVER)

	if (oq_idex > 1)
		if(length(curr_overlays))
			curr_overlays.Cut(1, oq_idex)
		oq_idex = 1





/subsystem/lighting/on_life()

	update_lights()
	update_corners()
	update_overlays()

	return TRUE
