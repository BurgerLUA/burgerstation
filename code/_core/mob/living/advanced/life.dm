/mob/living/advanced/death_message()
	src.do_emote("deathgasp")
	return TRUE


/mob/living/advanced/on_life_slow()

	. = ..()

	if(.)
		handle_organs()
		if(mood != 100)
			mood += clamp(100-mood,-TICKS_TO_SECONDS(LIFE_TICK_SLOW)*0.05,TICKS_TO_SECONDS(LIFE_TICK_SLOW)*0.05)
			mood = clamp(mood,0,200)
			for(var/obj/hud/button/mood/B in buttons)
				B.update_sprite()

/mob/living/advanced/pre_death()

	if(driving)
		driving.exit_vehicle(src,get_turf(driving))

	return ..()

mob/living/advanced/revive()

	var/species/S = SPECIES(species)
	if(!S)
		return FALSE
	if(sex == FEMALE)
		if(length(S.spawning_organs_female) > length(labeled_organs))
			return FALSE
	else
		if(length(S.spawning_organs_male) > length(labeled_organs))
			return FALSE

	. = ..()

	for(var/k in overlays_assoc)
		update_overlay_tracked(k, desired_plane = plane)

/mob/living/advanced/post_death()

	. = ..()

	if(!master)
		drop_hands(src.loc)
		right_hand?.release_object()
		left_hand?.release_object()

	for(var/k in overlays_assoc)
		update_overlay_tracked(k, desired_plane = plane)

	return TRUE

/mob/living/advanced/proc/handle_organs()

	if(!health)
		return FALSE

	for(var/k in labeled_organs)
		var/obj/item/organ/O = labeled_organs[k]
		CHECK_TICK(75,FPS_SERVER*2)
		if(O.has_life) O.on_life()

	return TRUE