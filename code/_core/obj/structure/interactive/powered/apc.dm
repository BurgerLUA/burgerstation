/obj/structure/interactive/powered/apc
	name = "area power converter"
	icon = 'icons/obj/structure/power.dmi'
	icon_state = "apc"

	desired_light_range = 1
	desired_light_power = 1
	desired_light_color = "#00FF00"

	plane = PLANE_OBJ

	var/obj/item/powercell/cell = /obj/item/powercell/industrial

/obj/structure/interactive/powered/apc/Generate()
	. = ..()
	if(ispath(cell))
		cell = new(src)
		INITIALIZE(cell)
		GENERATE(cell)
		FINALIZE(cell)

/obj/structure/interactive/powered/apc/update_overlays()

	. = ..()

	var/image/I1 = new/image(initial(icon),"apc_light")
	I1.plane = PLANE_EFFECT_LIGHTING

	var/image/I2 = new/image(initial(icon),"apc_light_2")
	I2.plane = PLANE_EFFECT_LIGHTING

	add_overlay(I1)
	add_overlay(I2)

/obj/structure/interactive/powered/apc/Initialize()
	setup_dir_offsets()
	. = ..()

/obj/structure/interactive/powered/apc/Finalize()
	. = ..()
	update_sprite()