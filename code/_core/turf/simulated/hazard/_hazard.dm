/turf/simulated/hazard/
	density = TRUE

	var/loot/fishing_rewards

/turf/simulated/hazard/is_safe_teleport(var/check_contents=TRUE)
	return FALSE

/turf/simulated/hazard/can_construct_on(var/mob/caller,var/obj/structure/structure_to_make)

	if(ispath(structure_to_make,/obj/structure/interactive/construction/))
		var/obj/structure/interactive/construction/C = locate() in contents
		if(C)
			caller.to_chat(span("warning","You can't build this here, \the [C.name] is in the way!"))
			return FALSE
		return TRUE

	. = ..()