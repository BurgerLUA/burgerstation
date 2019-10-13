/obj/chat_text
	name = "overlay"
	desc = "overlay object"
	plane = PLANE_CHAT

	icon = null

	var/mob/living/advanced/owner

/obj/chat_text/destroy()
	owner.stored_chat_text -= src
	owner = null
	return ..()

/obj/chat_text/New(var/atom/desired_loc,var/desired_text)

	if(is_advanced(desired_loc))
		owner = desired_loc

		for(var/obj/chat_text/CT in owner.stored_chat_text)
			qdel(CT)

		owner.stored_chat_text += src

		force_move(get_turf(desired_loc))

		maptext_width = TILE_SIZE*ceiling(VIEW_RANGE*0.5,2)
		maptext_x = -(maptext_width-TILE_SIZE)*0.5
		maptext_y = TILE_SIZE*0.75
		maptext = "<center>[desired_text]</center>"

		spawn(100)
			animate(src,alpha=0,time=10)
			sleep(10)
			if(src && !src.qdeleting)
				qdel(src)



		return ..()
	else
		qdel(src)

	return FALSE