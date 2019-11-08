obj/effect/temp/impact/blood
	name = "blood impact"
	icon = 'icons/obj/effects/blood_impact.dmi'
	icon_state = "1"
	layer = LAYER_BLOOD
	plane = PLANE_FLOOR

obj/effect/temp/impact/blood/New(var/desired_loc,var/desired_time,var/desired_color)
	icon_state = "[rand(1,12)]"
	color = desired_color
	return ..()


obj/effect/temp/impact/blood/small
	name = "drip of blood "
	icon = 'icons/obj/effects/blood_impact.dmi'
	icon_state = "1"
	layer = LAYER_BLOOD
	plane = PLANE_FLOOR
