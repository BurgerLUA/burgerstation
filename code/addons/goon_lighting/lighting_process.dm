/var/list/lighting_update_lights    = list()    // List of lighting sources  queued for update.
/var/list/lighting_update_corners   = list()    // List of lighting corners  queued for update.
/var/list/lighting_update_overlays  = list()    // List of lighting overlays queued for update.

/var/list/lighting_update_lights_old    // List of lighting sources  currently being updated.
/var/list/lighting_update_corners_old   // List of lighting corners  currently being updated.
/var/list/lighting_update_overlays_old  // List of lighting overlays currently being updated.

/var/lighting_processing            = TRUE

/world/New()
	. = ..()
	lighting_start_process()

/proc/lighting_start_process()
	set waitfor = FALSE
	while(lighting_processing)
		sleep(LIGHTING_INTERVAL)
		lighting_process()

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

	lighting_update_corners_old = lighting_update_corners
	lighting_update_corners = list()
	for(var/A in lighting_update_corners_old)
		var/datum/lighting_corner/C = A
		C.update_overlays()
		C.needs_update = FALSE

	lighting_update_overlays_old = lighting_update_overlays
	lighting_update_overlays = list()
	for(var/A in lighting_update_overlays_old)
		if(!A)
			continue

		var/atom/movable/lighting_overlay/L = A // Typecasting this later so BYOND doesn't istype each entry.
		L.update_overlay()
		L.needs_update = FALSE
