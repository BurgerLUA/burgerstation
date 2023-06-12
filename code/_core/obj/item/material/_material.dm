/obj/item/material/
	name = "glitch"
	desc = "I am error."
	icon = 'icons/obj/item/material.dmi'
	icon_state = "shard_1"

	var/material_id = /material/steel
	var/material_multiplier = 1

	amount_max = 50
	amount_max_icon = 3

	drop_sound = 'sound/items/drop/gascan.ogg'

	weight = 0.1

	value = 0 //Auto generated.

/obj/item/material/can_transfer_stacks_to(var/obj/item/target)

	if(target == src)
		return FALSE

	if(target.amount_max <= 1 || src.amount_max <= 1)
		return FALSE

	if(target.amount >= target.amount_max)
		return FALSE

	if(!istype(target,/obj/item/material/))
		return FALSE

	var/obj/item/material/M = target
	if(M.material_id != src.material_id)
		return FALSE

	if(M.crafting_id != src.crafting_id)
		return FALSE

	return TRUE

/obj/item/material/save_item_data(var/mob/living/advanced/player/P,var/save_inventory = TRUE,var/died=FALSE,var/loadout=FALSE)
	RUN_PARENT_SAFE
	SAVEPATH("material_id")

/obj/item/material/load_item_data_pre(var/mob/living/advanced/player/P,var/list/object_data,var/loadout=FALSE)
	RUN_PARENT_SAFE
	LOADPATH("material_id")

/obj/item/material/get_base_value()
	var/material/M = SSmaterials.all_materials[material_id]
	return M.value_per_unit * material_multiplier

/obj/item/material/Finalize()

	. = ..()

	if(!SSmaterials.all_materials[material_id])
		log_error("Warning: [src.get_debug_name()] had invalid material id \"[material_id]\".")
		qdel(src)
		return TRUE

	var/material/M = SSmaterials.all_materials[material_id]

	if(M.reagent && M.reagent_amount > 0)
		grinder_reagent = M.reagent
		grinder_reagent_amount = M.reagent_amount * material_multiplier

	update_value()
	update_sprite()