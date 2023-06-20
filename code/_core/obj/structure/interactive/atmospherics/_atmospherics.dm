obj/structure/interactive/atmospherics


obj/structure/interactive/atmospherics/vent
	name = "vent"
	desc = "Supplies oxygen. Or spicy air."
	desc_extended = "Decorative item. Currently has no use."
	icon = 'icons/obj/structure/atmos.dmi'
	icon_state = "vent_1"

	desired_light_range = 2
	desired_light_power = 1
	desired_light_color = "#64BEB5"

	plane = PLANE_FLOOR_ATTACHMENT
	layer = LAYER_FLOOR_VENT

obj/structure/interactive/atmospherics/scrubber
	name = "scrubber"
	desc = "Law 4: Oxygen is harmful to humans."
	desc_extended = "Decorative item. Currently has no use."
	icon = 'icons/obj/structure/atmos.dmi'
	icon_state = "scrubber_1"

	desired_light_range = 2
	desired_light_power = 1
	desired_light_color = "#BE6864"

	plane = PLANE_FLOOR_ATTACHMENT
	layer = LAYER_FLOOR_VENT

obj/structure/interactive/atmospherics/air_alarm
	name = "air alarm"
	desc = "'Pull in case of emergency' Hence, keep pulling it forever."
	desc_extended = "Decorative item. Currently has no use."
	icon = 'icons/obj/structure/atmos.dmi'
	icon_state = "air_alarm"

	desired_light_range = 2
	desired_light_power = 1
	desired_light_color = "#0094FF"

	plane = PLANE_MOVABLE

obj/structure/interactive/atmospherics/air_alarm/Initialize(var/desired_loc)
	try_attach_to()
	setup_dir_offsets()
	return ..()

obj/structure/interactive/atmospherics/air_alarm/PostInitialize()
	. = ..()
	update_sprite()


obj/structure/interactive/atmospherics/air_alarm/update_overlays()
	. = ..()
	var/image/I = new /image(initial(icon),"air_alarm_light")
	I.plane = PLANE_LIGHTING_EFFECT
	add_overlay(I)


obj/structure/interactive/atmospherics/fan
	name = "fan"
	desc = "Law 4: Oxygen is harmful to humans."
	desc_extended = "Decorative item. Currently has no use."
	icon = 'icons/obj/structure/atmos.dmi'
	icon_state = "fan_tiny"

	plane = PLANE_FLOOR
