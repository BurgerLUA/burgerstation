obj/effect/temp/blood/
	name = "blood"
	icon = 'icons/obj/effects/blood_impact.dmi'
	icon_state = "1"
	layer = LAYER_BLOOD
	plane = PLANE_FLOOR


obj/effect/temp/blood/drip/
	name = "blood drip"
	icon_state = "drip"

obj/effect/temp/blood/drip/New(var/desired_location,var/desired_time,var/desired_color,var/desired_x,var/desired_y)

	color = desired_color

	if(desired_x && desired_y)
		var/matrix/T = matrix()
		T.Turn(pick(0,90,180,270))
		transform = T
		animate(src,pixel_x = desired_x, desired_y, time = 2)
	else
		pixel_x = rand(-TILE_SIZE,TILE_SIZE)
		pixel_y = rand(-TILE_SIZE,TILE_SIZE)

	return ..()


