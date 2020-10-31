obj/structure/interactive/atmospherics


obj/structure/interactive/atmospherics/vent
	name = "vent"
	desc = "Supplies oxygen. Or spicy air."
	desc_extended = "Decorative item. Currenly has no use."
	icon = 'icons/obj/structure/atmos.dmi'
	icon_state = "vent_1"

	desired_light_range = 0.5
	desired_light_power = 1
	desired_light_color = "#0094FF"

	plane = PLANE_FLOOR

obj/structure/interactive/atmospherics/scrubber
	name = "scrubber"
	desc = "Law 4: Oxygen is harmfull to humans."
	desc_extended = "Decorative item. Currenly has no use."
	icon = 'icons/obj/structure/atmos.dmi'
	icon_state = "scrubber_1"

	desired_light_range = 0.5
	desired_light_power = 1
	desired_light_color = "#0094FF"

	plane = PLANE_FLOOR

obj/structure/interactive/atmospherics/air_alarm
	name = "air alarm"
	desc = "'Pull in case of emergency' Hence, keep pulling it forever."
	desc_extended = "Decorative item. Currenly has no use."
	icon = 'icons/obj/structure/atmos.dmi'
	icon_state = "air_alarm"

	desired_light_range = 1
	desired_light_power = 1
	desired_light_color = "#0094FF"

	plane = PLANE_OBJ

obj/structure/interactive/atmospherics/air_alarm/Initialize(var/desired_loc)
	setup_dir_offsets()
	return ..()

obj/structure/interactive/atmospherics/air_alarm/PostInitialize()
	. = ..()
	update_sprite()
	return .


obj/structure/interactive/atmospherics/air_alarm/update_overlays()
	. = ..()
	var/image/I = new /image(initial(icon),"air_alarm_light")
	I.plane = PLANE_EFFECT_LIGHTING
	add_overlay(I)
	return .


obj/structure/interactive/atmospherics/fan
	name = "fan"
	desc = "Law 4: Oxygen is harmfull to humans."
	desc_extended = "Decorative item. Currenly has no use."
	icon = 'icons/obj/structure/atmos.dmi'
	icon_state = "fan_tiny"

	plane = PLANE_FLOOR

	blocks_air = NORTH | EAST | SOUTH | WEST