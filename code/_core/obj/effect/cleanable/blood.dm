/obj/effect/cleanable/blood/
	name = "blood"
	icon = 'icons/obj/effects/blood_impact.dmi'
	color = "#990000"
	layer = LAYER_GROUND_SCENERY
	plane = PLANE_BLOOD
	alpha = 200

	var/animate_position = FALSE

	anchored = TRUE

/obj/effect/cleanable/blood/New(var/desired_location,var/desired_color,var/desired_x,var/desired_y)

	if(desired_color) color = desired_color

	var/matrix/T = matrix()
	transform = turn(T,pick(0,90,180,270))
	if(animate_position)
		animate(src,pixel_x = SAFENUM(desired_x), pixel_y = SAFENUM(desired_y), time = 5, easing = QUAD_EASING)
	else
		pixel_x = SAFENUM(desired_x)
		pixel_y = SAFENUM(desired_y)

	return ..()

/obj/effect/cleanable/blood/drip
	name = "blood drip"
	icon_state = "drip"
	animate_position = FALSE

/obj/effect/cleanable/blood/splatter/
	name = "blood splatter"
	icon_state = "1"
	animate_position = TRUE

/obj/effect/cleanable/blood/splatter/New(var/desired_location,var/desired_color,var/desired_x,var/desired_y)
	icon_state = "[rand(1,12)]"
	return ..()




