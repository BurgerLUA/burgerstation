/mob/living/advanced/proc/set_handcuffs(var/desired_handcuffs = TRUE,var/obj/item/handcuffs/handcuff_item)

	if(handcuffed == desired_handcuffs)
		return FALSE

	if(handcuff_item)
		handcuff_item.drop_item(src)
		stored_handcuffs = handcuff_item

	if(desired_handcuffs)
		handcuffs_overlay = new /image/overlay('icons/mob/living/advanced/overlays/handcuffs.dmi',"regular")
		handcuffs_overlay.plane = PLANE_MOB
		handcuffs_overlay.layer = LAYER_MOB_ABOVE
		add_tracked_overlay_image(handcuffs_overlay)
		drop_held_objects(get_turf(src))
	else
		remove_overlay_image(handcuffs_overlay)
		if(stored_handcuffs)
			stored_handcuffs.force_move(get_turf(src))
			stored_handcuffs = null

	handcuffed = !handcuffed
	handcuff_break_counter = 0

	return TRUE