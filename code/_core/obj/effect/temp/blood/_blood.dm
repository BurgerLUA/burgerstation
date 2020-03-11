/obj/blood/
	name = "blood"
	icon = 'icons/obj/effects/blood_impact.dmi'
	layer = LAYER_GROUND_SCENERY
	plane = PLANE_BLOOD
	alpha = 200

	reagents = /reagent_container/blood

	var/animate_position = FALSE

/obj/blood/update_icon()
	color = reagents.color
	return ..()

obj/blood/New(var/desired_location,var/desired_time,var/desired_color,var/desired_x,var/desired_y)

	color = desired_color

	var/matrix/T = matrix()
	transform = turn(T,pick(0,90,180,270))
	if(animate_position)
		animate(src,pixel_x = SAFENUM(desired_x), pixel_y = SAFENUM(desired_y), time = 2, easing = QUAD_EASING)
	else
		pixel_x = SAFENUM(desired_x)
		pixel_y = SAFENUM(desired_y)

	return ..()

/obj/blood/drip
	name = "blood drip"
	icon_state = "drip"
	animate_position = FALSE

/obj/blood/splatter/
	name = "blood splatter"
	icon_state = "1"
	animate_position = TRUE

/obj/blood/splatter/New(var/desired_location,var/desired_time,var/desired_color,var/desired_x,var/desired_y)
	icon_state = "[rand(1,12)]"
	return ..()




