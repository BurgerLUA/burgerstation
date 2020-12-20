obj/structure/interactive/sheet_maker
	name = "sheet maker"
	desc = "Makes sheets and sheet."
	icon = 'icons/obj/structure/sheet_maker.dmi'
	icon_state = "sheet_maker_map"

	var/obj/item/material/material_to_make = /obj/item/material/sheet/

	bullet_block_chance = 50

	density = TRUE

	desired_light_power = 0.25
	desired_light_range = 2
	desired_light_color = "#0000FF"

obj/structure/interactive/sheet_maker/PostInitialize()
	. = ..()
	update_sprite()
	return .

obj/structure/interactive/sheet_maker/update_icon()
	. = ..()
	icon_state = "sheet_maker"
	return .

obj/structure/interactive/sheet_maker/Cross(atom/movable/O)
	if(make_sheet(O))
		return FALSE
	return ..()

obj/structure/interactive/sheet_maker/proc/make_sheet(var/atom/movable/O)

	if(istype(O,/obj/item/material/))
		var/obj/item/material/M = O
		var/obj/item/material/NM = new material_to_make(src.loc)
		NM.item_count_current = M.item_count_current
		NM.material_id = M.material_id
		INITIALIZE(NM)
		FINALIZE(NM)
		NM.update_sprite()
		qdel(M)
		return TRUE

	return FALSE
