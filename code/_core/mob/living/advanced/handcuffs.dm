/mob/living/advanced/proc/set_handcuffs(var/desired_handcuffs = TRUE)

	if(handcuffed == desired_handcuffs)
		return FALSE

	if(desired_handcuffs)
		handcuffs_overlay = new /image/overlay('icons/mob/living/advanced/overlays/handcuffs.dmi',"regular")
		handcuffs_overlay.plane = PLANE_MOB
		handcuffs_overlay.layer = LAYER_MOB_ABOVE
		add_tracked_overlay_image(handcuffs_overlay)
		drop_held_objects(get_turf(src))
	else
		remove_overlay_image(handcuffs_overlay)

	handcuffed = !handcuffed
	handcuff_break_counter = 0

	return TRUE