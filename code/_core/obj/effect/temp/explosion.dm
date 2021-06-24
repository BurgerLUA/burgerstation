/obj/effect/temp/explosion
	name = "explosion effect"
	mouse_opacity = 0
	icon = 'icons/obj/effects/explosion.dmi'
	icon_state = "explosion"
	duration = SECONDS_TO_DECISECONDS(3)
	layer = LAYER_EFFECT + 0.1

/obj/effect/temp/explosion/New(var/desired_location,var/desired_time,var/desired_color)
	. = ..()
	var/matrix/M = get_base_transform()
	M.Scale(desired_time/5,desired_time/5)
	animate(src,transform = M,time = desired_time)

