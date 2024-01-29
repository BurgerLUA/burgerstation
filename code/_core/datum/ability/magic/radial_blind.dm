/ability/magic/radial_blind
	name = "radial blind"
	desc = "Blind all enemies around you in a small radius."
	icon_state = "blind"
	cost = 80
	cooldown = 30 SECONDS

/ability/magic/radial_blind/on_cast(mob/caller,atom/target,location,params)

	var/turf/T = get_turf(caller)
	new/obj/effect/temp/phase(T)

	var/loyalty_tag_to_use
	if(is_living(caller))
		var/mob/living/L_caller = caller
		loyalty_tag_to_use = L_caller.loyalty_tag

	play_sound('sound/weapons/magic/electrical_blast.ogg',T)

	for(var/mob/living/L in viewers(VIEW_RANGE,caller))
		if(!is_facing(L,caller))
			continue
		if(!allow_hostile_action(loyalty_tag_to_use,L))
			continue
		if(!L.flash(duration=100))
			continue
		var/turf/LT = get_turf(L)
		new/obj/effect/temp/sparkles(LT)

	return TRUE
