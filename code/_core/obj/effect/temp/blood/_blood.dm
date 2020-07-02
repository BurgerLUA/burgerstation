/obj/effect/blood/
	name = "blood"
	icon = 'icons/obj/effects/blood_impact.dmi'
	layer = LAYER_GROUND_SCENERY
	plane = PLANE_BLOOD
	alpha = 200

	var/animate_position = FALSE

	var/expense = 1

	anchored = TRUE

/obj/effect/blood/New(var/desired_location,var/desired_color,var/desired_x,var/desired_y)

	color = desired_color

	var/matrix/T = matrix()
	transform = turn(T,pick(0,90,180,270))
	if(animate_position)
		animate(src,pixel_x = SAFENUM(desired_x), pixel_y = SAFENUM(desired_y), time = 5, easing = QUAD_EASING)
	else
		pixel_x = SAFENUM(desired_x)
		pixel_y = SAFENUM(desired_y)

	return ..()

/obj/effect/blood/drip
	name = "blood drip"
	icon_state = "drip"
	animate_position = FALSE

	expense = 0.5

/obj/effect/blood/splatter/
	name = "blood splatter"
	icon_state = "1"
	animate_position = TRUE

	expense = 1

/obj/effect/blood/splatter/New(var/desired_location,var/desired_color,var/desired_x,var/desired_y)
	icon_state = "[rand(1,12)]"
	return ..()




