/obj/effect/temp/healing
	name = "healing effect"
	mouse_opacity = 0
	icon = 'icons/obj/effects/healing.dmi'
	icon_state = "heal"
	duration = 3 SECONDS
	color = "#FF0000"

/obj/effect/temp/healing/New(var/desired_location,var/desired_time,var/desired_color)

	if(desired_color)
		color = desired_color

	pixel_x = rand(-16,16)
	pixel_y = rand(-16,16)

	return ..()




/obj/effect/temp/electricity
	name = "electricity effect"
	mouse_opacity = 0
	icon = 'icons/obj/effects/sparkles.dmi'
	icon_state = "sparks"
	duration = 1 SECONDS



/obj/effect/temp/emp_pulse
	name = "EMP effect"
	mouse_opacity = 0
	icon = 'icons/obj/effects/sparkles.dmi'
	icon_state = "emppulse"
	duration = 1 SECONDS

/obj/effect/temp/emp_sparkle
	name = "EMP effect"
	mouse_opacity = 0
	icon = 'icons/obj/effects/sparkles.dmi'
	icon_state = "empdisable"
	duration = 1 SECONDS
