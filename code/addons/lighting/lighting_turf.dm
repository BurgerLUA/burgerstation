/turf
	var/dynamic_lighting = FALSE
	luminosity           = 1

	var/tmp/lighting_corners_initialised = FALSE

	var/tmp/list/light_source/affecting_lights       // List of light sources affecting this turf.
	var/tmp/atom/movable/lighting_overlay/lighting_overlay // Our lighting overlay.
	var/tmp/list/lighting_corner/corners
	var/tmp/has_opaque_atom = FALSE // Not to be confused with opacity, this will be TRUE if there's any opaque atom on the tile.

// Causes any affecting light sources to be queued for a visibility update, for example a door got opened.
/turf/proc/reconsider_lights()
	var/light_source/L
	for (var/thing in affecting_lights)
		L = thing
		L.vis_update()

// Forces a lighting update. Reconsider lights is preferred when possible.
/turf/proc/force_update_lights()
	var/light_source/L
	for (var/thing in affecting_lights)
		L = thing
		L.force_update()

/turf/proc/lighting_clear_overlay()
	if (lighting_overlay)
		if (lighting_overlay.loc != src)
			var/turf/badT = lighting_overlay.loc
			log_error("Lighting overlay variable on turf at ([x],[y],[z]) is insane, lighting overlay actually located at ([badT.x],[badT.y],[badT.z])!")

		QDEL_NULL(lighting_overlay)

	for (var/lighting_corner/C in corners)
		C.update_active()

// Builds a lighting overlay for us, but only if our area is dynamic.
/turf/proc/lighting_build_overlay()
	if (lighting_overlay)
		return

	if (TURF_IS_DYNAMICALLY_LIT_UNSAFE(src))
		if (!lighting_corners_initialised || !corners)
			generate_missing_corners()

		new /atom/movable/lighting_overlay(src)

		for (var/lighting_corner/C in corners)
			if (!C.active) // We would activate the corner, calculate the lighting for it.
				for (var/L in C.affecting)
					var/light_source/S = L
					S.recalc_corner(C, TRUE)

				C.active = TRUE

// Returns the average color of this tile. Roughly corresponds to the color of a single old-style lighting overlay.
/turf/proc/get_avg_color()
	if (!lighting_overlay)
		return null

	var/lum_r
	var/lum_g
	var/lum_b

	for (var/lighting_corner/L in corners)
		lum_r += L.apparent_r
		lum_g += L.apparent_g
		lum_b += L.apparent_b

	lum_r = CLAMP01(lum_r / 4) * 255
	lum_g = CLAMP01(lum_g / 4) * 255
	lum_b = CLAMP01(lum_b / 4) * 255

	return "#[num2hex(lum_r, 2)][num2hex(lum_g, 2)][num2hex(lum_g, 2)]"


// Used to get a scaled lumcount.
/turf/proc/get_lumcount(minlum = 0, maxlum = 1)
	if (!lighting_overlay)
		return (minlum + maxlum)/2

	var/totallums = 0
	for (var/lighting_corner/L in corners)
		totallums += L.apparent_r + L.apparent_b + L.apparent_g

	totallums /= 12 // 4 corners, each with 3 channels, get the average.

	totallums = SCALE(totallums, minlum, maxlum)

	return CLAMP01(totallums)

#undef SCALE

// Can't think of a good name, this proc will recalculate the has_opaque_atom variable.
/turf/proc/recalc_atom_opacity()
#ifdef AO_USE_LIGHTING_OPACITY
	var/old = has_opaque_atom
#endif

	has_opaque_atom = FALSE
	if (opacity)
		has_opaque_atom = TRUE
		return TRUE

	for (var/thing in src) // Loop through every movable atom on our tile
		var/atom/movable/A = thing
		if (A.opacity)
			has_opaque_atom = TRUE
			break 	// No need to continue if we find something opaque.

	return has_opaque_atom

#ifdef AO_USE_LIGHTING_OPACITY
	if (old != has_opaque_atom)
		regenerate_ao()
#endif

// If an opaque movable atom moves around we need to potentially update visibility.
/turf/Entered(atom/movable/Obj, atom/OldLoc)

	. = ..()

	if (Obj && Obj.opacity && !has_opaque_atom)
		has_opaque_atom = TRUE // Make sure to do this before reconsider_lights(), incase we're on instant updates. Guaranteed to be on in this case.
		reconsider_lights()

#ifdef AO_USE_LIGHTING_OPACITY
		// Hook for AO.
		regenerate_ao()
#endif

/turf/Exited(atom/movable/Obj, atom/newloc)

	. = ..()

	if (Obj && Obj.opacity)
		recalc_atom_opacity() // Make sure to do this before reconsider_lights(), incase we're on instant updates.
		reconsider_lights()

// This is inlined in lighting_source.dm.
// Update it too if you change this.
/turf/proc/generate_missing_corners()
	if (!TURF_IS_DYNAMICALLY_LIT_UNSAFE(src) && !light_sources)
		return

	lighting_corners_initialised = TRUE
	if (!corners)
		corners = new(4)

	for (var/i = 1 to 4)
		if (corners[i]) // Already have a corner on this direction.
			continue

		corners[i] = new/lighting_corner(src, LIGHTING_CORNER_DIAGONAL[i], i)