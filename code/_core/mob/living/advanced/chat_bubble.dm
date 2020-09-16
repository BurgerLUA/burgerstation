/*
		var/obj/overlay/spawned_overlay = new /obj/overlay
		spawned_overlay.layer = LAYER_EFFECT
		spawned_overlay.icon = 'icons/mob/living/advanced/overlays/talk.dmi'
		if(is_typing)
			spawned_overlay.icon_state = "talking"
		else
			spawned_overlay.icon_state = talk_type

		add_overlay(spawned_overlay)
*/


/mob/living/proc/do_type(var/type_type)
	talk_duration = SECONDS_TO_DECISECONDS(4)
	chat_overlay.icon_state = type_type
	chat_overlay.pixel_x = pixel_x
	chat_overlay.pixel_y = pixel_y
	chat_overlay.pixel_z = pixel_z
	chat_overlay.alpha = 255

/mob/living/proc/start_typing()
	is_typing = TRUE
	chat_overlay.icon_state = "talking"
	chat_overlay.pixel_x = pixel_x
	chat_overlay.pixel_y = pixel_y
	chat_overlay.pixel_z = pixel_z
	chat_overlay.alpha = 255

/mob/living/proc/end_typing()
	is_typing = FALSE
	chat_overlay.icon_state = "none"
