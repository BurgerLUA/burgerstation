/turf/proc/change_turf(var/turf/N, var/force_lighting_update = FALSE) //Stolen from /vg/. Don't use before INITIALIZE is called.

	if(!N)
		CRASH("change_turf() was provided a null turf!")

	var/old_opacity = opacity
	var/old_dynamic_lighting = dynamic_lighting
	var/old_affecting_lights = affecting_lights
	var/old_lighting_overlay = lighting_overlay
	var/old_corners = corners
	var/old_disallow_generation = disallow_generation

	var/list/old_stored_shuttle_items = src.stored_shuttle_items

	pre_change()

	var/old_turf_type = src.type

	src.initialized = FALSE
	src.finalized = FALSE
	src.generated = FALSE
	QDEL_NULL(health)

	var/turf/W = new N(src)
	INITIALIZE(W)
	GENERATE(W)
	FINALIZE(W)
	. = W
	W.disallow_generation = old_disallow_generation

	W.recalculate_atom_opacity()
	W.recalculate_atom_density()
	W.recalculate_atom_hazards()

	if(SSlighting && SSlighting.initialized)
		W.lighting_overlay = old_lighting_overlay
		W.affecting_lights = old_affecting_lights
		W.corners = old_corners
		if((old_opacity != W.opacity) || (W.dynamic_lighting != old_dynamic_lighting) || force_lighting_update)
			W.reconsider_lights()
			//force_update_lights()
		if(W.dynamic_lighting != old_dynamic_lighting)
			if(W.dynamic_lighting)
				W.lighting_build_overlay()
			else
				W.lighting_clear_overlay()

	var/area/A = W.loc
	if(A && A.sunlight_freq > 0 && A.sunlight_color)
		A.setup_sunlight(W)

	stored_shuttle_items = old_stored_shuttle_items

	W.post_change_turf(old_turf_type)

	if(W.density)
		for(var/k in W.contents)
			var/atom/movable/M = k
			if(M.density && W.Enter(M,W))
				W.Enter(M,W)
				W.Entered(M,W)

	HOOK_CALL("change_turf")


/turf/simulated/change_turf(var/turf/N, var/force_lighting_update = FALSE) //Stolen from /vg/. Don't use before INITIALIZE is called.

	var/old_corner_icons = corner_icons

	destroy_attachments()

	. = ..()

	if(. && is_simulated(src) && (corner_icons || old_corner_icons) && SSsmoothing.initialized)
		if(corner_icons != old_corner_icons)
			SSsmoothing.queue_update_edges(src)
		else
			queue_smoothing_turf(src)

/turf/proc/change_area(var/area/N) //Remember to call A.generate_average() when done changing areas.

	if(!N)
		CRASH("change_area() was provided a null area!")

	var/area/A = SSarea.all_areas[N]
	if(!A)
		CRASH("change_area() had an invalid area type ([N])!")

	if(src.loc == A)
		return FALSE

	A.contents += src

	return TRUE


/turf/proc/post_change_turf(var/old_turf_type)
	return TRUE