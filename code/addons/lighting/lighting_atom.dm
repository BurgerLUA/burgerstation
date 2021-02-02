#define MINIMUM_USEFUL_LIGHT_RANGE 1.4

/atom/
	var/light_power = 1 // Intensity of the light.
	var/light_range = 0 // Range in tiles of the light.
	var/light_color     // Hexadecimal RGB string representing the colour of the light.
	var/light_wedge		// The angle that the light's emission should be restricted to. null for omnidirectional.
	// These two vars let you override the default light offset detection (pixel_x/y).
	//  Useful for objects like light fixtures that aren't visually in the middle of the turf, but aren't offset either.
	var/light_offset_x
	var/light_offset_y

	var/tmp/light_source/light // Our light source. Don't fuck with this directly unless you have a good reason!
	var/tmp/list/light_sources       // Any light sources that are "inside" of us, for example, if src here was a mob that's carrying a flashlight, that flashlight's light source would be part of this list.

// The proc you should always use to set the light of this atom.
/atom/proc/set_light(l_range, l_power, l_color = NONSENSICAL_VALUE, angle = NONSENSICAL_VALUE, no_update = FALSE,debug = FALSE)

	if(!isnum(l_range))
		CRASH_SAFE("Light range set to null!")
		return

	if(l_range > 0 && l_range < MINIMUM_USEFUL_LIGHT_RANGE)
		l_range = MINIMUM_USEFUL_LIGHT_RANGE	//Brings the range up to 1.4, which is the lowest value that you can really see.

	if (l_power != null)
		light_power = l_power

	if (l_range != null)
		light_range = l_range

	if (l_color != NONSENSICAL_VALUE)
		light_color = l_color

	if (angle != NONSENSICAL_VALUE)
		light_wedge = angle

	if(no_update)
		return

	update_light(debug)

#undef NONSENSICAL_VALUE

// Will update the light (duh).
// Creates or destroys it if needed, makes it update values, makes sure it's got the correct source turf...
/atom/proc/update_light(debug)

	if(qdeleting)
		if(debug) log_debug("Light for [src.get_debug_name()] is being deleted as the object is being deleted.")
		QDEL_NULL(light) //TODO: Does this work?
		return

	if (!light_power || !light_range) // We won't emit light anyways, destroy the light source.
		if(debug) log_debug("Light for [src.get_debug_name()] is being deleted as there is no light power ([light_power]) or light range ([light_range]).")
		QDEL_NULL(light)
	else
		if(light)
			light.update()
			if(debug) log_debug("Light for [src.get_debug_name()] is being updated.")
		else
			light = new /light_source(src)
			if(debug) log_debug("Light for [src.get_debug_name()] is being created.")

// If we have opacity, make sure to tell (potentially) affected light sources.
/atom/movable/Destroy()

	var/turf/T = loc

	. = ..()

	if (opacity && istype(T))
		T.recalc_atom_opacity()
		T.reconsider_lights()

	return .


// Should always be used to change the opacity of an atom.
// It notifies (potentially) affected light sources so they can update (if needed).
/atom/proc/set_opacity(var/new_opacity,var/force = FALSE)

	if(!force && new_opacity == opacity)
		return FALSE

	opacity = new_opacity

	if (!isturf(loc))
		return

	var/turf/T = loc

	if (new_opacity) //We're opaque for sure.
		T.has_opaque_atom = TRUE
		T.reconsider_lights()
#ifdef AO_USE_LIGHTING_OPACITY
		T.regenerate_ao()
#endif
	else
		var/old_has_opaque_atom = T.has_opaque_atom
		T.recalc_atom_opacity()
		if (old_has_opaque_atom != T.has_opaque_atom)
			T.reconsider_lights()


	return TRUE

/atom/set_dir(var/desired_dir,var/force = FALSE)

	. = ..()

	var/light_source/L
	var/thing
	for (thing in light_sources)
		L = thing
		L.source_atom.update_light()

	return .