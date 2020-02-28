/obj/structure/interactive/fire_alarm
	name = "fire alarm"
	icon = 'icons/obj/structure/fire_alarm.dmi'
	icon_state = "fire_alarm"

	desired_light_range = 0.5
	desired_light_power = 1
	desired_light_color = "#00FF00"

/obj/structure/interactive/fire_alarm/Initialize(var/desired_loc)
	setup_dir_offsets()
	return ..(loc)