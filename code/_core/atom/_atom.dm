/atom/

	name = "atom"
	desc = "What the fuck is this?"
	desc_extended = "Such a strange object. I bet not even the gods themselves know what this thing is. Who knows what mysteries it can hold?"
	id = null

	var/health_max = 0
	var/health_current = 0
	var/health_regeneration = 0

	var/list/damage = list(BRUTE = 0, BURN = 0, TOX = 0, OXY = 0)
	var/list/damage_soft = list(BRUTE = 0, BURN = 0, TOX = 0, OXY = 0)

	var/damage_soft_total = 0

	var/throw_speed = 8 //How far the object travels in pixels per decisecond, when thrown

	var/damage_type //The id of the damage type of the weapon, if any.

	var/list/resistance = list(BRUTE = 0, BURN = 0, TOX = 0, OXY = 0) //How much to subtract damage

	var/attack_range = 1 //If it's a melee weapon, it needs a range.

	var/attack_delay = 4
	var/attack_last = 0

	var/initialized = FALSE

	plane = PLANE_DEFAULT

	var/list/additional_blends = list()

	var/override_icon = FALSE

	var/wound/wounds = list()

	var/light_power = 1 // Intensity of the light.
	var/light_range = 0 // Range in tiles of the light.
	var/light_color     // Hexadecimal RGB string representing the colour of the light.

	var/tmp/datum/light_source/light // Our light source. Don't fuck with this directly unless you have a good reason!
	var/tmp/list/light_sources       // Any light sources that are "inside" of us, for example, if src here was a mob that's carrying a flashlight, that flashlight's light source would be part of this list.

	var/list/overlays_assoc

	var/doing_progress = FALSE


	var/collision_flags = FLAG_COLLISION_NONE
	density = FALSE //DEPCRECATED

	var/interact_distance = 1

	var/thinks = FALSE

/atom/destroy()
	invisibility = 101
	if(light)
		light.destroy_light()
		light = null
	if(thinks)
		all_thinkers -= src
	return ..()

/atom/proc/can_collide_with(var/atom/A)
	return A.collision_flags & src.collision_flags

/atom/Cross(var/atom/A)

	if(A.can_collide_with(src))
		return FALSE

	return ..()

/atom/proc/Initialize()
	initialized = TRUE
	return TRUE

/atom/New()

	. = ..()

	if(light_power && light_range)
		update_light()

	if(opacity && isturf(loc))
		var/turf/T = loc
		T.has_opaque_atom = TRUE // No need to recalculate it in this case, it's guaranteed to be on afterwards anyways.

	overlays_assoc = list()

	if(thinks)
		all_thinkers += src

	return .

// Should always be used to change the opacity of an atom.
// It notifies (potentially) affected light sources so they can update (if needed).
/atom/proc/set_opacity(var/new_opacity)
	if (new_opacity == opacity)
		return

	opacity = new_opacity
	var/turf/T = loc
	if (!isturf(T))
		return

	if (new_opacity == TRUE)
		T.has_opaque_atom = TRUE
		T.reconsider_lights()
	else
		var/old_has_opaque_atom = T.has_opaque_atom
		T.recalc_atom_opacity()
		if (old_has_opaque_atom != T.has_opaque_atom)
			T.reconsider_lights()
/*
/atom/proc/can_not_leave(var/atom/A,var/move_direction)
	return null

/atom/proc/can_not_enter(var/atom/A,var/move_direction)
	return null
*/

/atom/proc/defer_click_on_object()
	return src

/atom/proc/get_xp_multiplier() //How much XP should this object give for interacting with it.
	return 0

/atom/proc/can_be_attacked(var/atom/attacker)
	return TRUE

/atom/proc/can_be_grabbed(var/atom/grabber)
	return FALSE

/atom/Entered()
	..()
	for(var/datum/light_source/L in src.light_sources) // Cycle through the light sources on this atom and tell them to update.
		L.source_atom.update_light()

#define NONSENSICAL_VALUE -99999
/atom/proc/set_light(l_range, l_power, l_color = NONSENSICAL_VALUE)
	if(l_power != null) light_power = l_power
	if(l_range != null) light_range = l_range
	if(l_color != NONSENSICAL_VALUE) light_color = l_color

	update_light()
#undef NONSENSICAL_VALUE

/atom/proc/get_light_source()
	return src

/atom/movable/get_light_source()
	return loc.get_light_source()

/atom/proc/update_light()
	set waitfor = FALSE
	if(qdeleting)
		return

	if(!light_power || !light_range) // We won't emit light anyways, destroy the light source.
		if(light)
			light.destroy_light()
			light = null
	else

		/*
		if(istype(loc, /atom/movable)) // We choose what atom should be the top atom of the light here.
			. = loc
		else
			. = src
		*/

		. = get_light_source()

		if(light) // Update the light or create it if it does not exist.
			light.update(.)
		else
			light = new/datum/light_source(src, .)

/atom/proc/on_progress_bar_completed(var/id,var/list/callback_list)
	return TRUE

/atom/proc/on_progress_bar_failed(var/id,var/list/callback_list)
	return TRUE

/atom/proc/think()
	return TRUE //Return false to remove from thinking.