/obj/item/material/ingot
	name = "ingot"
	desc = "I am error."

	icon = 'icons/obj/item/material.dmi'
	icon_state = "ingot"

	amount_max = 50
	amount_max_icon = 6

/obj/item/material/ingot/update_icon()
	var/material/M = SSmaterials.all_materials[material_id]
	if(!M)
		name = "ERROR ingot"
		log_error("Warning! [src.get_debug_name()] had incorrect material type \"[material_id]\"!")
	else
		name = "[deunderscore(M.name)] ingot"
		desc_extended = "An ingot of [deunderscore(M.name)]. Made by smelting raw ore or alloying."
		icon_state = "[M.icon_state_ingot]_[min(CEILING(amount/10,1),amount_max_icon)]"
		color = M.color
	return ..()