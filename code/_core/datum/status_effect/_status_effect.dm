/status_effect/
	var/name //Name of the Status Effect
	var/desc //Description of the status effect.
	var/id //Status effect description
	var/maximum = -1 //Maximium time, in deciseconds, that someone can have this effect. Set to -1 to ignore.
	var/minimum = -1 //Maximium time, in deciseconds, that someone can have this effect. Set to -1 to ignore.

	var/default_magnitude = 100
	var/default_duration = -1

	var/affects_dead = TRUE

/status_effect/proc/modify_duration(var/atom/attacker,var/mob/living/owner,var/duration)
	return duration

/status_effect/proc/modify_magnitude(var/atom/attacker,var/mob/living/owner,var/magnitude)
	return magnitude

/status_effect/proc/can_add_status_effect(var/atom/attacker,var/mob/living/victim)

	if(victim.dead && !affects_dead)
		return FALSE

	return TRUE

/status_effect/proc/on_effect_added(var/mob/living/owner,var/atom/source,var/magnitude,var/duration,var/stealthy)

	if(!stealthy)
		var/turf/T = get_turf(owner)
		if(T) new/obj/effect/temp/status_effect(T,clamp(duration,10,100),"[uppertext(name)]!")

	return TRUE

/status_effect/proc/on_effect_removed(var/mob/living/owner,var/magnitude,var/duration)
	return TRUE

/status_effect/proc/on_effect_life(var/mob/living/owner,var/magnitude,var/duration)
	return TRUE