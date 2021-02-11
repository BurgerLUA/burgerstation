/obj/item/material/
	name = "glitch"
	desc = "I am error."
	icon = 'icons/obj/item/material.dmi'
	icon_state = "shard_1"

	var/material_id = /material/steel
	var/material_multiplier = 1

	item_count_current = 1
	item_count_max = 50
	item_count_max_icon = 3

	crafting_id = "material"

	value = 1

	drop_sound = 'sound/items/drop/gascan.ogg'

	weight = 0.1

/obj/item/material/save_item_data(var/save_inventory = TRUE)
	. = ..()
	SAVEPATH("material_id")
	return .

/obj/item/material/load_item_data_pre(var/mob/living/advanced/player/P,var/list/object_data)
	. = ..()
	LOADPATH("material_id")
	return .

/obj/item/material/Initialize()
	if(!SSmaterials.all_materials[material_id])
		log_error("Warning: [src.get_debug_name()] had invalid material id \"[material_id]\".")
		qdel(src)
		return TRUE

	var/material/M = SSmaterials.all_materials[material_id]
	crafting_id = "[crafting_id]_[M.name]"

	return ..()

/obj/item/material/PostInitialize()
	. = ..()
	update_sprite()
	return .

/obj/item/material/get_base_value()
	var/material/M = SSmaterials.all_materials[material_id]
	return ..() * M.value_per_unit * material_multiplier

/*
/obj/item/material/Crossed(atom/movable/O)

	if(!istype(O,/obj/item/material))
		return ..()

	var/obj/item/material/M = O
	if(M.crafting_id != src.crafting_id)
		return ..()

	if(M.item_count_max <= M.item_count_current)
		return ..()

	src.transfer_item_count_to(M)
	return TRUE
*/