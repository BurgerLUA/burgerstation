/obj/effect/temp/blood/
	name = "blood"
	icon = 'icons/obj/effects/blood_impact.dmi'
	layer = LAYER_GROUND_SCENERY
	plane = PLANE_BLOOD
	alpha = 150

	var/animate_position = FALSE

/obj/effect/temp/blood/New(var/desired_location,var/desired_time,var/desired_color,var/desired_x,var/desired_y)

	var/blood_count = 0

	for(var/obj/effect/temp/blood/B in src.loc.contents)
		blood_count++

	if(blood_count > 5)
		desired_time = SECONDS_TO_DECISECONDS(4)

	color = desired_color

	var/matrix/T = matrix()
	transform = turn(T,pick(0,90,180,270))
	if(animate_position)
		animate(src,pixel_x = SAFENUM(desired_x), pixel_y = SAFENUM(desired_y), time = 5, easing = QUAD_EASING)
	else
		pixel_x = SAFENUM(desired_x)
		pixel_y = SAFENUM(desired_y)

	spawn(desired_time-20)
		animate(src,alpha = 0,time = 20)

	return ..()

/obj/effect/temp/blood/drip
	name = "blood drip"
	icon_state = "drip"
	animate_position = FALSE

/obj/effect/temp/blood/splatter/
	name = "blood splatter"
	icon_state = "1"
	animate_position = TRUE

/obj/effect/temp/blood/splatter/New(var/desired_location,var/desired_time,var/desired_color,var/desired_x,var/desired_y)
	icon_state = "[rand(1,12)]"
	return ..()




