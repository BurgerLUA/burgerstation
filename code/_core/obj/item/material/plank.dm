/obj/item/material/plank
	name = "plank"
	desc = "I am error."
	icon = 'icons/obj/item/material.dmi'
	icon_state = "wood"

	amount_max = 50
	amount_max_icon = 3

	drop_sound = 'sound/items/drop/wooden.ogg'

	material_multiplier = 1

	value = 0

/obj/item/material/plank/update_icon()
	var/material/M = SSmaterials.all_materials[material_id]
	if(!M)
		name = "ERROR plank"
		log_error("Warning! [src.get_debug_name()] had incorrect material type \"[material_id]\"!")
	else
		name = "[deunderscore(M.name)] plank"
		desc = "If you build it..."
		desc_extended = "A sheet made of [deunderscore(M.name)]. Useful for building and crafting."
		icon_state = "[M.icon_state_sheet]_[min(CEILING(amount/10,1),amount_max_icon)]"
		color = M.color
	return ..()