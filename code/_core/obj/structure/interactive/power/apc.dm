/obj/structure/interactive/power/apc
	name = "area power converter"
	icon = 'icons/obj/structure/power.dmi'
	icon_state = "apc"

	desired_light_range = 1
	desired_light_power = 1
	desired_light_color = "#00FF00"

	plane = PLANE_OBJ

	var/obj/item/powercell/cell = /obj/item/powercell

	wire_powered = TRUE

/obj/structure/interactive/power/apc/get_examine_list(var/mob/examiner)
	. = ..()
	. += div("notice","Area Power Draw: [src.power_draw]w.")
	. += div("notice","\The [cell.name] has [cell.charge_current] out of [cell.charge_max] charge remaining.")

/obj/structure/interactive/power/apc/Destroy()

	if(istype(cell))
		QDEL_NULL(cell)

	. = ..()

/obj/structure/interactive/power/apc/Initialize()
	setup_dir_offsets()
	. = ..()

/obj/structure/interactive/power/apc/Finalize()
	. = ..()
	var/area/A = get_area(src)
	if(A.apc)
		log_error("Warning: Duplicate [src.get_debug_name()] created in [A.type].")
		qdel(src)
	else if(!A.requires_power)
		log_error("Warning: Created [src.get_debug_name()] in an [A.type] that doesn't require power.")
		qdel(src)
	else
		A.apc = src
		SSpower.all_apc_areas |= A
		update_sprite()

/obj/structure/interactive/power/apc/Generate()
	. = ..()
	if(ispath(cell))
		cell = new(src)
		INITIALIZE(cell)
		GENERATE(cell)
		FINALIZE(cell)
		cell.charge_current = rand(cell.charge_max*0.5,cell.charge_max*0.75)

/obj/structure/interactive/power/apc/update_overlays()

	. = ..()

	var/image/I1 = new/image(initial(icon),"apc_light")
	I1.plane = PLANE_EFFECT_LIGHTING

	var/image/I2 = new/image(initial(icon),"apc_light_2")
	I2.plane = PLANE_EFFECT_LIGHTING

	add_overlay(I1)
	add_overlay(I2)

/obj/structure/interactive/power/apc/get_power_draw()
	return cell ? min(max(0,cell.charge_max - cell.charge_current),CEILING(cell.charge_max*0.25,1)) : 0

/obj/structure/interactive/power/apc/power_process(var/power_multiplier=1)
	. = ..()
	update_power_draw(get_power_draw())
	cell.charge_current += FLOOR(power_draw*power_multiplier,1)
