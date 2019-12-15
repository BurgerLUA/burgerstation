/obj/hud/button/ping
	name = "ping"
	icon_state = "ping"
	maptext = "<div align='right'>???ms </div>"

	flags = FLAGS_HUD_MOB

	screen_loc = "RIGHT,TOP:10"

	thinks = TRUE

	maptext_x = -2

/obj/hud/button/ping/think()

	if(!is_mob(owner))
		return FALSE

	var/mob/M = owner

	if(!M.client)
		return FALSE

	maptext = "<div align='right'>[ceiling(M.client.ping - world.time)]ms</div>"

	return ..()
