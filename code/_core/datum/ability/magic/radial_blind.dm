/ability/magic/radial_blind
	name = "radial blind"
	desc = "Blind all enemies around you in a small radius."
	icon_state = "blind"
	cost = 80
	cooldown = SECONDS_TO_DECISECONDS(30)

/ability/magic/radial_blind/on_cast(var/mob/activator,var/atom/target,location,params)

	var/turf/T = get_turf(activator)
	new/obj/effect/temp/phase(T)

	var/loyalty_tag_to_use
	if(is_living(activator))
		var/mob/living/L_activator = activator
		loyalty_tag_to_use = L_activator.loyalty_tag

	play_sound('sound/weapons/magic/electrical_blast.ogg',T)

	for(var/mob/living/L in viewers(VIEW_RANGE,activator))
		if(!is_facing(L,activator))
			continue
		if(!allow_hostile_action(loyalty_tag_to_use,L))
			continue
		if(!L.flash(duration=100))
			continue
		var/turf/LT = get_turf(L)
		new/obj/effect/temp/sparkles(LT)

	return TRUE
