/obj/structure/interactive/power/


/obj/structure/interactive/power/apc
	name = "area power converter"
	icon = 'icons/obj/structure/power.dmi'
	icon_state = "apc"

	desired_light_range = 1
	desired_light_power = 1
	desired_light_color = "#00FF00"


/obj/structure/interactive/power/apc/update_overlays()

	. = ..()

	var/image/I1 = new/image(initial(icon),"apc_light")
	I1.plane = PLANE_LIGHTING
	I1.layer = 99

	var/image/I2 = new/image(initial(icon),"apc_light")
	I2.plane = PLANE_LIGHTING
	I2.layer = 99

	overlays += I1
	overlays += I2

	return .


/obj/structure/interactive/power/apc/Initialize(var/desired_loc)
	setup_dir_offsets()
	update_sprite()
	return ..(loc)