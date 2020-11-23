/mob/living/advanced/death_message()
	src.do_emote("deathgasp")
	return TRUE


/mob/living/advanced/on_life_slow()

	. = ..()

	if(.)
		handle_organs()
		handle_sanity()


	return .

/mob/living/advanced/pre_death()

	if(driving)
		driving.exit_vehicle(src,get_turf(driving))

	return ..()

/*
/mob/living/advanced/do_loot_drop(var/atom/desired_loc)

	if(health && desired_loc && loot_drop && is_item(desired_loc))
		var/obj/item/I = desired_loc
		var/loot/L = all_loot[loot_drop]
		if(!L)
			return FALSE
		L.spawn_loot_container(desired_loc)

		var/obj/item/currency/C = new(src.loc)
		C.value = 1 + FLOOR(health.health_max/10, 1)
		INITIALIZE(C)
		I.add_to_inventory(null,C,FALSE)
		return TRUE

	return FALSE
*/

mob/living/advanced/revive()

	. = ..()

	for(var/k in overlays_assoc)
		update_overlay_tracked(k, desired_plane = plane)

	return .

/mob/living/advanced/post_death()

	. = ..()

	drop_held_objects(src.loc)
	for(var/obj/hud/inventory/I in inventory)
		if(I.grabbed_object)
			I.release_object()

	for(var/k in overlays_assoc)
		update_overlay_tracked(k, desired_plane = plane)

	return TRUE

/mob/living/advanced/proc/handle_organs()

	if(!health)
		return FALSE

	for(var/k in labeled_organs)
		var/obj/item/organ/O = labeled_organs[k]
		CHECK_TICK(75,FPS_SERVER*2)
		if(O.has_life)
			O.on_life()

	return TRUE

/mob/living/advanced/proc/handle_sanity()

	if(client && isturf(loc)) //If you afk in darkness, your sanity doesn't go down or up.
		var/turf/T = loc
		if(T.darkness <= 0.1)
			sanity -= (1/6) // 10 minutes of darkness will make you "insane".
		else if(T.darkness >= 0.9)
			sanity += (1/18) // 30 minutes of light will get you from insane to completely sane.
		sanity = clamp(sanity,1,100)

	return TRUE
