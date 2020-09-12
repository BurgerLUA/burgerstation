/mob/living/advanced/death_message()
	src.emote("deathgasp")
	return TRUE

/mob/living/advanced/on_life()

	. = ..()

	if(.)
		if(talk_duration)
			talk_duration = max(0,talk_duration-LIFE_TICK)
			if(talk_duration <= 0 && !is_typing)
				animate(chat_overlay,alpha = 0,time=SECONDS_TO_DECISECONDS(1))

	return .


/mob/living/advanced/on_life_slow()


	. = ..()

	if(.)
		handle_organs()

	return .

/mob/living/advanced/pre_death()
	return TRUE

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
