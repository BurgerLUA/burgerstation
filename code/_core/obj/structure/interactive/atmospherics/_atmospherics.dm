obj/structure/interactive/atmospherics


obj/structure/interactive/atmospherics/vent
	name = "vent"
	icon = 'icons/obj/structure/atmos.dmi'
	icon_state = "vent_1"

	desired_light_range = 0.5
	desired_light_power = 1
	desired_light_color = "#0094FF"

obj/structure/interactive/atmospherics/scrubber
	name = "scrubber"
	icon = 'icons/obj/structure/atmos.dmi'
	icon_state = "scrubber_1"

	desired_light_range = 0.5
	desired_light_power = 1
	desired_light_color = "#0094FF"

obj/structure/interactive/atmospherics/air_alarm
	name = "air alarm"
	icon = 'icons/obj/structure/atmos.dmi'
	icon_state = "air_alarm_1"

	desired_light_range = 1
	desired_light_power = 1
	desired_light_color = "#0094FF"

obj/structure/interactive/atmospherics/air_alarm/Initialize(var/desired_loc)
	setup_dir_offsets()
	return ..(loc)
