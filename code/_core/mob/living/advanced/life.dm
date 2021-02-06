/mob/living/advanced/death_message()
	src.do_emote("deathgasp")
	return TRUE


/mob/living/advanced/on_life_slow()

	. = ..()

	if(.)
		handle_organs()
		handle_sanity()


	return .

/*
/mob/living/advanced/pre_death()

	if(driving)
		driving.exit_vehicle(src,get_turf(driving))

	return ..()
*/

mob/living/advanced/revive()

	. = ..()

	for(var/k in overlays_assoc)
		update_overlay_tracked(k, desired_plane = plane)

	return .

/mob/living/advanced/post_death()

	. = ..()

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

/mob/living/advanced/proc/handle_sanity()

	if(client && isturf(loc)) //If you afk in darkness, your sanity doesn't go down or up.
		var/turf/T = loc
		if(T.lightness <= 0.1)
			sanity -= (1/6) // 10 minutes of darkness will make you "insane".
		else if(T.lightness >= 0.9)
			sanity += (1/18) // 30 minutes of light will get you from insane to completely sane.
		sanity = clamp(sanity,1,100)

	return TRUE
