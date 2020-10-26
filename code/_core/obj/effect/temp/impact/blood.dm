//This is for the transparent blood effect
/obj/effect/temp/impact/blood
	name = "blood impact"
	icon = 'icons/obj/effects/blood_impact.dmi'
	icon_state = "1"
	duration = 3
	alpha = 150

/obj/effect/temp/impact/blood/New(var/desired_loc,var/desired_time,var/desired_color)
	icon_state = "[rand(1,12)]"
	color = desired_color
	alpha = 0
	animate(src,pixel_x=rand(-8,8),pixel_y=rand(-8,8),alpha=initial(alpha),time=duration)
	return ..()