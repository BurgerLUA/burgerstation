/turf/proc/change_turf(var/turf/N, var/force_lighting_update = FALSE, var/force_edges_update = FALSE) //Stolen from /vg/

	if(!N)
		return FALSE

	var/old_opacity = opacity
	var/old_dynamic_lighting = dynamic_lighting
	var/old_affecting_lights = affecting_lights
	var/old_lighting_overlay = lighting_overlay
	var/old_corners = corners

	var/turf/W = new N(src)
	W.Initialize()
	. = W

	recalc_atom_opacity()
	if(SSlighting && SSlighting.initialized)
		lighting_overlay = old_lighting_overlay
		affecting_lights = old_affecting_lights
		corners = old_corners
		if((old_opacity != opacity) || (dynamic_lighting != old_dynamic_lighting) || force_lighting_update)
			reconsider_lights()
		if(dynamic_lighting != old_dynamic_lighting)
			if(dynamic_lighting)
				lighting_build_overlay()
			else
				lighting_clear_overlay()
	if(force_edges_update)
		update_edges()
	else
		queue_update_edges(src)

	return .