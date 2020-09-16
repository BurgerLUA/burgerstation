/obj/effect/chat_text
	name = "overlay"
	desc = "overlay object"
	plane = PLANE_HUD_CHAT

	icon = null

	var/mob/owner

	mouse_opacity = 0

/obj/effect/chat_text/Destroy()

	if(owner)
		owner.stored_chat_text -= src
		owner = null

	return ..()

#define CHAT_TEXT_CHARACTER_LIMIT 144

/obj/effect/chat_text/New(var/atom/desired_loc,var/desired_text,var/bypass_length=FALSE)

	if(ismob(desired_loc))

		owner = desired_loc

		for(var/k in owner.stored_chat_text)
			var/obj/effect/chat_text/CT = k
			animate(CT,pixel_y = CT.pixel_y + 8,time = 5)

		owner.stored_chat_text += src

		src.alpha = 0
		src.pixel_y = -8
		animate(src,pixel_y = 0, alpha = 255, time = 5)
		force_move(get_turf(desired_loc))

		maptext_width = TILE_SIZE*CEILING(VIEW_RANGE*2*0.75,2)
		maptext_x = -(maptext_width-TILE_SIZE)*0.5
		maptext_y = TILE_SIZE*0.75

		if(!bypass_length && length(desired_text) > CHAT_TEXT_CHARACTER_LIMIT) //52 is a magic number because reasons.
			desired_text = copytext(desired_text,1,CHAT_TEXT_CHARACTER_LIMIT) + "..."

		maptext = "<center><font color='white' style='-dm-text-outline: 1 black'>[html_decode(desired_text)]</font></center>"

		spawn(50)
			animate(src,alpha=0,time=10)
			sleep(10)
			if(src && !src.qdeleting)
				qdel(src)



		return ..()
	else
		qdel(src)

	return FALSE