/obj/structure/interactive/fire_alarm
	name = "fire alarm"
	desc = "'Pull in case of emergency' Hence, keep pulling it forever."
	desc_extended = "Decorative item. Currenly has no use."
	icon = 'icons/obj/structure/fire_alarm.dmi'
	icon_state = "fire_alarm"

	desired_light_range = 0.5
	desired_light_power = 1
	desired_light_color = "#00FF00"

	plane = PLANE_OBJ

/obj/structure/interactive/fire_alarm/Initialize()
	setup_dir_offsets()
	return ..()