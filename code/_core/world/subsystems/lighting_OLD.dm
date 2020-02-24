/var/list/lighting_update_lights    = list()    // List of lighting sources  queued for update.
/var/list/lighting_update_corners   = list()    // List of lighting corners  queued for update.
/var/list/lighting_update_overlays  = list()    // List of lighting overlays queued for update.

/var/list/lighting_update_lights_old    // List of lighting sources  currently being updated.
/var/list/lighting_update_corners_old   // List of lighting corners  currently being updated.
/var/list/lighting_update_overlays_old  // List of lighting overlays currently being updated.

/var/lighting_processing            = TRUE

SUBSYSTEM_DEF(lighting)
	name = "Lighting Subsystem"
	desc = "Controls the lighting."
	tick_rate = DECISECONDS_TO_TICKS(LIGHTING_INTERVAL)
	priority = SS_ORDER_LIGHTING

/subsystem/lighting/Initialize()

	if(!ENABLE_LIGHTING)
		return FALSE

	create_all_lighting_overlays()
	lighting_process()

/subsystem/lighting/on_life()

	if(!ENABLE_LIGHTING)
		return FALSE

	lighting_process()
	return TRUE

/proc/create_all_lighting_overlays()
	for(var/zlevel = 1 to world.maxz)
		create_lighting_overlays_zlevel(zlevel)

/proc/turf_has_lighting(var/turf/T)
	if(!T.dynamic_lighting)
		return FALSE

	var/area/A = T.loc
	if(!A.dynamic_lighting)
		return FALSE

	return TRUE

/proc/create_lighting_overlays_zlevel(var/zlevel)

	ASSERT(zlevel)

	var/lighting_counter = 0

	for(var/turf/simulated/T in block(locate(1, 1, zlevel), locate(world.maxx, world.maxy, zlevel)))
		if(!turf_has_lighting(T))
			continue
		lighting_counter += 1
		getFromPool(/atom/movable/lighting_overlay, T, TRUE)
		sleep(-1)

	LOG_DEBUG("Initialized [lighting_counter] lights for zlevel [zlevel].")

/proc/lighting_process()
	lighting_update_lights_old = lighting_update_lights
	lighting_update_lights = list()
	for(var/datum/light_source/L in lighting_update_lights_old)
		if(L.check() || L.destroyed || L.force_update)
			L.remove_lum()
			if(!L.destroyed)
				L.apply_lum()

		else if(L.vis_update)	// We smartly update only tiles that became (in) visible to use.
			L.smart_vis_update()

		L.vis_update   = FALSE
		L.force_update = FALSE
		L.needs_update = FALSE
		sleep(-1)

	lighting_update_corners_old = lighting_update_corners
	lighting_update_corners = list()
	for(var/A in lighting_update_corners_old)
		var/datum/lighting_corner/C = A
		C.update_overlays()
		C.needs_update = FALSE
		sleep(-1)

	lighting_update_overlays_old = lighting_update_overlays
	lighting_update_overlays = list()
	for(var/A in lighting_update_overlays_old)
		if(!A)
			continue

		var/atom/movable/lighting_overlay/L = A // Typecasting this later so BYOND doesn't istype each entry.
		L.update_overlay()
		L.needs_update = FALSE
		sleep(-1)
