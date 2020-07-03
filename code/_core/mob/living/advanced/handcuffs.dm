/mob/living/advanced/proc/set_handcuffs(var/desired_handcuffs = TRUE,var/obj/item/handcuffs/handcuff_item)

	if(handcuffed == desired_handcuffs)
		return FALSE

	if(handcuff_item)
		handcuff_item.drop_item(src)
		handcuff_item.force_move(src)
		stored_handcuffs = handcuff_item

	if(desired_handcuffs)
		update_overlay_tracked("handcuffs", desired_icon = 'icons/mob/living/advanced/overlays/handcuffs.dmi', desired_icon_state = "regular")
		drop_held_objects(get_turf(src))
	else
		remove_overlay("handcuffs")
		if(stored_handcuffs)
			stored_handcuffs.force_move(get_turf(src))
			stored_handcuffs = null

	handcuffed = !handcuffed
	handcuff_break_counter = 0

	return TRUE