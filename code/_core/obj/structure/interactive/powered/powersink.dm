/obj/structure/interactive/powered/powersink
	name = "powersink"
	icon = 'icons/obj/structure/power.dmi'
	icon_state = "apc"

	wire_powered = TRUE

/obj/structure/interactive/powered/powersink/get_power_draw()
	return 500