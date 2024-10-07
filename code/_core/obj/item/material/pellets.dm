/obj/item/material/pellets
	name = "pellets"
	desc = "If only there was a pellet gun."
	icon = 'icons/obj/item/material.dmi'
	icon_state = "pellets"

	amount_max = 500 //They're small.
	amount_max_icon = 3

	value = 0

/obj/item/material/pellets/update_icon()
	var/material/M = SSmaterials.all_materials[material_id]
	if(!M)
		name = "ERROR pellets"
		log_error("Warning! [src.get_debug_name()] had incorrect material type \"[material_id]\"!")
	else
		name = "[deunderscore(M.name)] pellets"
		desc_extended = "Pellets made of [deunderscore(M.name)]. Useful for crafting."
		icon_state = "[M.icon_state_rod]_[min(CEILING(amount/10,1),amount_max_icon)]"
		color = M.color
	return ..()