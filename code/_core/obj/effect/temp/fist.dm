obj/effect/temp/fist
	name = "FIST"
	icon = 'icons/obj/effects/fist_small.dmi'
	icon_state = "fist"
	desc = "Rip."
	duration = 10
	pixel_x = -TILE_SIZE*0.5

obj/effect/temp/fist/New(var/desired_location,var/desired_time,var/desired_color)
	. = ..()
	pixel_z = TILE_SIZE*2
	animate(src,pixel_z=0,time=desired_time*0.25)
	return .

