obj/structure/scenery/hellfire
	name = "fire"
	desc = "Thanks, science!"
	icon = 'icons/obj/effects/fire.dmi'
	icon_state = "3"

	desired_light_power = 0.25
	desired_light_range = 8
	desired_light_color = "#FF7F00"

obj/structure/scenery/hellfire/New(var/desired_loc)

	set_dir(pick(NORTH,EAST,SOUTH,WEST))

	return ..()