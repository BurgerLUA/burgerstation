/mob/living/advanced/proc/set_handcuffs(var/desired_handcuffs = TRUE,var/obj/item/handcuffs/handcuff_item)

	if(!overlays_assoc["handcuffs"])
		CRASH_SAFE("WARNING: [src.get_debug_name()] didn't have a handcuff overlay!")
		return FALSE

	if(handcuffed == desired_handcuffs)
		return FALSE

	if(handcuff_item)
		handcuff_item.drop_item(src)
		stored_handcuffs = handcuff_item

	if(desired_handcuffs)
		update_overlay_tracked("handcuffs", desired_icon = 'icons/mob/living/advanced/overlays/handcuffs.dmi', desired_icon_state = "regular")
		add_status_effect(DISARM,100,100)
	else
		update_overlay_tracked("handcuffs", desired_icon = 'icons/mob/living/advanced/overlays/handcuffs.dmi', desired_icon_state = "none")
		if(stored_handcuffs)
			stored_handcuffs.drop_item(get_turf(src))
			stored_handcuffs = null

	handcuffed = desired_handcuffs
	handcuff_break_counter = 0

	return TRUE