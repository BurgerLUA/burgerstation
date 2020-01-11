obj/effect/temp/shuttle_landing
	name = "shuttle landing effect"
	icon = 'icons/obj/effects/landing.dmi'
	icon_state = "shuttle"
	duration = 18

obj/effect/temp/shuttle_landing/New(var/desired_loc)
	alpha = 0
	animate(src, alpha = 255,time = duration)
	return ..()