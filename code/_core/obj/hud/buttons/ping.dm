/obj/hud/button/ping
	name = "ping"
	icon_state = "ping"
	maptext = "<div align='right'>???ms </div>"

	flags = FLAGS_HUD_MOB

	screen_loc = "RIGHT,TOP:10"

	maptext_x = -2

	has_quick_function = FALSE

/obj/hud/button/ping/New(var/desired_loc)
	start_thinking(src)
	return ..()

/obj/hud/button/ping/think()

	if(!ismob(owner))
		return FALSE

	var/mob/M = owner

	if(!M.client)
		return FALSE

	maptext = "<div align='right'>[CEILING(M.client.ping_num, 1)]ms</div>"

	return TRUE