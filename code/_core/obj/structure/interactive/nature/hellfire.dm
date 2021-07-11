obj/structure/scenery/hellfire
	name = "fire"
	desc = "Thanks, science!"
	icon = 'icons/obj/effects/fire.dmi'
	icon_state = "3"

obj/structure/scenery/hellfire/New(var/desired_loc)
	set_dir(pick(NORTH,EAST,SOUTH,WEST))
	. = ..()
