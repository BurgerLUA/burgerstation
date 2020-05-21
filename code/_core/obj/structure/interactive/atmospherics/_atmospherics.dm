obj/structure/interactive/atmospherics


obj/structure/interactive/atmospherics/vent
	name = "vent"
	icon = 'icons/obj/structure/atmos.dmi'
	icon_state = "vent"

	desired_light_range = 0.5
	desired_light_power = 1
	desired_light_color = "#0094FF"

	plane = PLANE_TILE

obj/structure/interactive/atmospherics/scrubber
	name = "scrubber"
	icon = 'icons/obj/structure/atmos.dmi'
	icon_state = "scrubber"

	desired_light_range = 0.5
	desired_light_power = 1
	desired_light_color = "#0094FF"

	plane = PLANE_TILE

obj/structure/interactive/atmospherics/air_alarm
	name = "air alarm"
	icon = 'icons/obj/structure/atmos.dmi'
	icon_state = "air_alarm"

	desired_light_range = 1
	desired_light_power = 1
	desired_light_color = "#0094FF"

	plane = PLANE_WALL_ATTACHMENTS

obj/structure/interactive/atmospherics/air_alarm/Initialize(var/desired_loc)
	setup_dir_offsets()
	update_sprite()
	return ..(loc)


obj/structure/interactive/atmospherics/air_alarm/update_overlays()
	. = ..()
	var/image/I = new /image(initial(icon),"air_alarm_light")
	I.plane = PLANE_LIGHTING
	I.layer = 99
	add_overlay(I)
	return .


obj/structure/interactive/atmospherics/fan
	name = "fan"
	icon = 'icons/obj/structure/atmos.dmi'
	icon_state = "fan_tiny"

	plane = PLANE_TILE

	blocks_air = NORTH | EAST | SOUTH | WEST