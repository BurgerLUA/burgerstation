/obj/item/material/trash_cube
	name = "trash cube"
	desc = "I am error."
	icon = 'icons/obj/item/material.dmi'
	icon_state = "trash_cube"

	amount_max = 50
	amount_max_icon = 3

	crafting_id = "trash_cube"

	material_multiplier = 1

	value = 0

/obj/item/material/trash_cube/update_icon()
	var/material/M = SSmaterials.all_materials[material_id]
	if(!M)
		name = "ERROR cube"
		log_error("Warning! [src.get_debug_name()] had incorrect material type \"[material_id]\"!")
	else
		name = "[deunderscore(M.name)] cube"
		desc_extended = "A cube made of [deunderscore(M.name)]. It came from a trash compactor."
		color = M.color
	return ..()