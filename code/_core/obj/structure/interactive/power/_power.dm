/obj/structure/interactive/power/


/obj/structure/interactive/power/apc
	name = "area power converter"
	icon = 'icons/obj/structure/power.dmi'
	icon_state = "apc_1"

	desired_light_range = 1
	desired_light_power = 1
	desired_light_color = "#00FF00"

/obj/structure/interactive/power/apc/Initialize(var/desired_loc)
	setup_dir_offsets()
	return ..(loc)