/obj/structure/interactive/smelter
	name = "smelter"
	desc = "A furnace used to smelt ores"
	desc_extended = "Ore that goes from one side via conveyor comes out smelted into ingots out the other."
	icon = 'icons/obj/structure/smelter.dmi'
	icon_state = "furnace"

	plane = PLANE_MOVABLE
	anchored = TRUE
	pixel_y = 2

	bullet_block_chance = 50

	density = TRUE

	desired_light_power = 0.25
	desired_light_range = 2
	desired_light_color = "#FFFF00"

/obj/structure/interactive/smelter/PostInitialize()
	. = ..()
	update_sprite()

/obj/structure/interactive/smelter/update_overlays()

	. = ..()

	pixel_y = 6

	var/image/I1 = new/image(icon,"furnace_left")
	I1.pixel_x = 4 - TILE_SIZE

	var/image/I2 = new/image(icon,"furnace_right")
	I2.pixel_x = TILE_SIZE - 4

	add_overlay(I1)
	add_overlay(I2)


/obj/structure/interactive/smelter/proc/smelt()

	for(var/obj/item/material/ore/O in contents)
		if(O.amount >= 3)
			var/material/material = O.material_id
			var/ingottype = "/obj/item/material/ingot/[initial(material.name)]"
			var/tocheck = text2path_safe(ingottype)
			if(ispath(tocheck))
				var/obj/item/material/ingot/I = new ingottype(src.loc)
				INITIALIZE(I)
				GENERATE(I)
				FINALIZE(I)
				O.add_item_count(-3)
	return
/obj/structure/interactive/smelter/proc/stack(var/obj/item/material/ore/O)

	for(var/obj/item/material/ore/C in contents)
		if(!C || C.qdeleting)
			continue
		if(O || O.qdeleting)
			break
		if(!O.can_transfer_stacks_to(C))
			continue
		O.transfer_amount_to(C)
		if(O.qdeleting)
			break
		CHECK_TICK(50,FPS_SERVER)

/obj/structure/interactive/smelter/Crossed(atom/movable/O,atom/OldLoc)
	if(istype(O,/obj/item/material/ore/))
		var/obj/item/material/ore/T = O
		T.drop_item(src)
		stack(T)
	smelt()
	return ..()
/obj/structure/interactive/smelter/clicked_on_by_object(mob/caller, atom/object, location, control, params)
	if(istype(object,/obj/item))
		var/obj/item/T = object
		if(T.flags_tool & FLAG_TOOL_WRENCH)
			if(anchored)
				caller.to_chat(span("notice","You un-anchor the smelter."))
				anchored = FALSE
			else
				caller.to_chat(span("notice","You anchor the smelter."))
				anchored = TRUE
	else
		for(var/obj/item/T in contents)
			T.drop_item(get_turf(caller))
		caller.to_chat(span("notice","You empty the smelter."))
	. = ..()
