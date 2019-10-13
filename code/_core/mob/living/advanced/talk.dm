/mob/living/advanced/proc/update_talking_icons()
	if(is_typing || talk_type)
		var/obj/overlay/spawned_overlay = new /obj/overlay
		spawned_overlay.layer = LAYER_EFFECT
		spawned_overlay.icon = 'icons/mob/living/advanced/overlays/talk.dmi'
		if(is_typing)
			spawned_overlay.icon_state = "talking"
		else
			spawned_overlay.icon_state = talk_type

		overlays += spawned_overlay