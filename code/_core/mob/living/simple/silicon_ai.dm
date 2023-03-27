/mob/living/simple/silicon/ai
	name = "The AI"
	icon = 'icons/mob/living/simple/ai.dmi'
	icon_state = "idle"

	ai = /ai/boss/ai_core

	var/next_spawner_spawn = 0

	var/list/linked_spawners = list()
	var/list/linked_generators = list()

	health_base = 1000
	stamina_base = 50
	mana_base = 50

	anchored = TRUE
	density = TRUE

/mob/living/simple/silicon/ai/proc/spawn_spawners()

	if(!z)
		return FALSE

	var/leap_distance = round(VIEW_RANGE,2) //Needs to be even.
	var/list/all_directions = DIRECTIONS_ALL
	for(var/k in all_directions)
		var/list/offsets = direction_to_pixel_offset(k)
		var/turf/simulated/T = locate(x + offsets[1]*leap_distance,y + offsets[2]*leap_distance,z)
		if(!T || !is_simulated(T))
			continue
		var/maximum_checks = 4 //This probably won't happen but this is really just in case some fuckery happens.
		while(maximum_checks > 0 && T.density && T.health)
			maximum_checks--
			if(maximum_checks > 0 && T.destruction_turf && !initial(T.destruction_turf.density))
				T.change_turf(T.destruction_turf)
			else
				T.change_turf(/turf/simulated/floor/plating)
			sleep(-1)
		var/mob/living/simple/silicon/spawner/S = locate() in T.contents
		if(S)
			if(S.dead)
				gib(S)
			continue
		S = new /mob/living/simple/silicon/spawner(T)
		INITIALIZE(S)
		GENERATE(S)
		FINALIZE(S)
		linked_spawners += S

	next_spawner_spawn = world.time + SECONDS_TO_DECISECONDS(60)

/mob/living/simple/silicon/ai/remove_status_effect(var/status_type,var/check_horizontal=TRUE)
	. = ..()
	if(.)
		update_icon()

/mob/living/simple/silicon/ai/add_status_effect(var/status_type,var/magnitude,var/duration,var/atom/source,var/force=FALSE,var/stealthy=FALSE,var/bypass_limits=FALSE)
	. = ..()
	if(.)
		update_icon()

/mob/living/simple/silicon/ai/Destroy()
	linked_spawners.Cut()
	linked_spawners = null
	. = ..()

/mob/living/simple/silicon/ai/update_icon()
	. = ..()
	icon_state = initial(icon_state)
	if(dead)
		icon_state = "dead"
	else if(has_status_effect(STUN))
		icon_state = "stunned"
	else if(ai && ai.objective_attack)
		icon_state = "living"

/mob/living/simple/silicon/ai/death(var/silent=TRUE)
	. = ..()
	if(.)
		for(var/k in linked_spawners)
			var/mob/living/L = k
			L.death(silent)


/mob/living/simple/silicon/ai/post_death()
	. = ..()
	update_icon()



/mob/living/simple/silicon/ai/on_damage_received(var/atom/atom_damaged,var/atom/attacker,var/atom/weapon,var/damagetype/DT,var/list/damage_table,var/damage_amount,var/critical_hit_multiplier,var/stealthy=FALSE)

	. = ..()

	if(damage_amount >= 15 && prob(damage_amount) && (icon_state == "living" || icon_state == "stunned"))
		flick("[icon_state]_damage",src)