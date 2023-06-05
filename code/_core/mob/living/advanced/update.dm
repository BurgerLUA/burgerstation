/mob/living/advanced/proc/update_items(var/force=FALSE) //Sent when an item needs to update.

	if(qdeleting) //Bandaid fix.
		return FALSE

	if(!force && !finalized)
		return FALSE //Don't want to call this too much during initializations.

	var/total_weight = 0
	var/max_weight = 50 + get_attribute_power(ATTRIBUTE_ENDURANCE)*450

	move_delay_multiplier = 1 //The lower the value, the faster you are.
	var/list/blocking_clothing = list()
	var/list/hidden_organs = list()

	overall_clothing_defense_rating = list()

	for(var/k in held_objects)
		var/obj/item/I = k
		total_weight += I.weight

	for(var/k in worn_objects)
		var/obj/item/I = k
		total_weight += I.weight
		if(!is_clothing(I))
			continue
		var/obj/item/clothing/C = I
		var/obj/hud/inventory/INV = C.loc
		if(!INV || !INV.worn)
			continue
		move_delay_multiplier -= C.speed_bonus
		if(C.hidden_organs && !(C.enable_torn_overlay && C.get_damage_icon_number() > 0))
			hidden_organs |= C.hidden_organs
			blocking_clothing[C] = TRUE
		if(!C.armor)
			continue
		var/armor/A = ARMOR(C.armor)
		if(!A)
			continue
		for(var/d_type in A.defense_rating)
			if(IS_INFINITY(A.defense_rating[d_type]))
				overall_clothing_defense_rating[d_type] = INFINITY
				continue
			if(IS_INFINITY(overall_clothing_defense_rating[d_type]))
				continue
			overall_clothing_defense_rating[d_type] += A.defense_rating[d_type]

	move_delay_multiplier *= 1 + (total_weight/max_weight)
	move_delay_multiplier = FLOOR(max(0.25,move_delay_multiplier),0.01)

	/*
	for(var/k in overlays_assoc)
		var/image/overlay/O = overlays_assoc[k]
		var/obj/item/I = O.attached_object
		if(!I)
			continue
		if(is_organ(I))
			var/obj/item/organ/OR = I
			update_overlay_tracked(k, !hidden_organs[OR.id] ? 255 : 0)
			continue
		if(!I.loc || !is_organ(I.loc.loc))
			continue
		var/obj/item/organ/OR = I.loc.loc
		update_overlay_tracked(k, (blocking_clothing[I] || !hidden_organs[OR.id]) ? 255 : 0)
	*/

	return TRUE



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