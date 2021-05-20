/turf/proc/change_turf(var/turf/N, var/force_lighting_update = FALSE, var/force_edges_update = FALSE) //Stolen from /vg/. Don't use before INITIALIZE is called.

	if(!N)
		return FALSE

	var/old_opacity = opacity
	var/old_dynamic_lighting = dynamic_lighting
	var/old_affecting_lights = affecting_lights
	var/old_lighting_overlay = lighting_overlay
	var/old_corners = corners
	var/old_disallow_generation = disallow_generation

	for(var/obj/effect/footprint/F in src.contents)
		qdel(F)

	for(var/obj/effect/cleanable/C in src.contents)
		qdel(C)

	for(var/obj/structure/scenery/S in src.contents)
		qdel(S)

	if(src in SSturfs.wet_turfs)
		SSturfs.wet_turfs -= src

	var/old_turf_type = src.type

	var/turf/W = new N(src)
	W.initialized = FALSE
	W.finalized = FALSE
	W.generated = FALSE
	INITIALIZE(W)
	FINALIZE(W)
	. = W
	W.disallow_generation = old_disallow_generation

	W.recalc_atom_opacity()
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

	if(force_edges_update)
		update_edges()
	else
		queue_update_turf_edges(W)

	var/area/A = W.loc
	if(A && A.sunlight_freq > 0 && A.sunlight_color)
		A.setup_sunlight(W)

	W.post_change_turf(old_turf_type)

/turf/proc/post_change_turf(var/old_turf_type)
	return TRUE