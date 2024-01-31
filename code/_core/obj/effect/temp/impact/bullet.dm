obj/effect/temp/impact/bullet
	name = "bullet impact"
	icon = 'icons/obj/effects/bullet_impact.dmi'
	icon_state = "bullet"
	duration = SECONDS_TO_DECISECONDS(30)
	layer = LAYER_PROJECTILE

obj/effect/temp/impact/bullet/New(var/desired_location,var/desired_time,var/desired_pixel_x,var/desired_pixel_y,var/desired_color)
	. = ..()
	color = desired_color
	pixel_x = desired_pixel_x
	pixel_y = desired_pixel_y


obj/effect/temp/impact/bullet/laser
	icon_state = "laser"

