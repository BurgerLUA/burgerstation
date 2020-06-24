/obj/structure/interactive/fire_alarm
	name = "fire alarm"
	icon = 'icons/obj/structure/fire_alarm.dmi'
	icon_state = "fire_alarm"

	desired_light_range = 0.5
	desired_light_power = 1
	desired_light_color = "#00FF00"

	plane = PLANE_WALL_ATTACHMENTS

/obj/structure/interactive/fire_alarm/Initialize()
	setup_dir_offsets()
	return ..()