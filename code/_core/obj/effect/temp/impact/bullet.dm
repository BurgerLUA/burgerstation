obj/effect/temp/impact/bullet
	name = "bullet impact"
	icon = 'icons/obj/effects/bullet_impact.dmi'
	icon_state = "bullet"
	duration = 100
	layer = LAYER_PROJECTILE

obj/effect/temp/impact/bullet/New(var/desired_location,var/desired_time,var/desired_pixel_x,var/desired_pixel_y)
	. = ..()
	pixel_x = desired_pixel_x
	pixel_y = desired_pixel_y
	world.log << "Pixel x: [pixel_x], Pixel y: [pixel_y]"
	return .


obj/effect/temp/impact/bullet/laser
	icon_state = "laser"