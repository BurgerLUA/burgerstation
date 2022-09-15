/mob/living/advanced/proc/update_clothes()

	tracked_hidden_organs = list()

	var/list/blocking_clothing = list()

	for(var/obj/item/clothing/C in worn_objects)
		if(C.enable_torn_overlay && C.get_damage_icon_number() > 0)
			continue
		if(C.hidden_organs)
			tracked_hidden_organs |= C.hidden_organs
			blocking_clothing[C] = TRUE

	for(var/k in overlays_assoc)
		var/image/overlay/O = overlays_assoc[k]
		var/obj/item/I = O.attached_object
		if(!I)
			continue
		if(is_organ(I))
			var/obj/item/organ/OR = I
			show_overlay(k, !tracked_hidden_organs[OR.id] ? TRUE : FALSE)
		else
			var/atom/movable/M = I
			if(!M.loc || !is_organ(M.loc.loc))
				continue
			var/obj/item/organ/OR = M.loc.loc
			show_overlay(k, (blocking_clothing[M] || !tracked_hidden_organs[OR.id]) ? TRUE : FALSE)

	return TRUE

/mob/living/advanced/proc/update_items(var/force=FALSE,var/should_update_speed=TRUE,var/should_update_eyes=TRUE,var/should_update_protection=TRUE,var/should_update_clothes=TRUE) //Sent when an item needs to update.

	if(qdeleting) //Bandaid fix.
		return FALSE

	if(!force && !finalized)
		return FALSE //Don't want to call this too much during initializations.

	if(should_update_speed) //Weight too.
		update_speed()
	if(should_update_eyes)
		update_eyes()
	if(should_update_protection)
		update_protection()
	if(should_update_clothes)
		update_clothes()

	return TRUE

/mob/living/advanced/proc/update_speed()

	var/total_weight = 0
	var/max_weight = 50 + get_attribute_power(ATTRIBUTE_ENDURANCE)*450

	. = 1 //The lower the value, the faster you are.

	for(var/obj/item/clothing/C in worn_objects)
		. -= C.speed_bonus
		total_weight += C.weight

	. *= 1 + (total_weight/max_weight)

	. = FLOOR(max(0.25,.),0.01)

	move_delay_multiplier = .

/mob/living/advanced/update_eyes()

	. = ..()

	var/area/A = get_area(src)
	if(A && !(A.flags_area & FLAG_AREA_SINGLEPLAYER))
		see_invisible = max(see_invisible,INVISIBILITY_PLAYERS)

	for(var/obj/item/organ/eye/E in organs)
		sight |= E.sight_mod
		vision |= E.vision_mod
		see_invisible = max(E.see_invisible,see_invisible)
		see_in_dark = max(see_in_dark,E.see_in_dark)

	for(var/obj/item/clothing/glasses/G in worn_objects)
		sight |= G.sight_mod
		vision |= G.vision_mod
		see_invisible = max(G.see_invisible,see_invisible)
		see_in_dark = max(see_in_dark,G.see_in_dark)