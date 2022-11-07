/obj/item/material/update_icon()
	var/material/M = SSmaterials.all_materials[material_id]
	color = M.color
	material = list()
	material[material_id] = amount * 1000
	return ..()

/obj/item/material/sheet/update_icon()
	var/material/M = SSmaterials.all_materials[material_id]
	if(!M)
		name = "ERROR sheet"
		log_error("Warning! [src.get_debug_name()] had incorrect material type \"[material_id]\"!")
	else
		name = "[M.name] sheet"
		desc = "If you build it..."
		desc_extended = "A sheet made of [M.name]. Useful for building and crafting."
		icon_state = "[M.icon_state_sheet]_[min(CEILING(amount/10,1),amount_max_icon)]"
	return ..()

/obj/item/material/rod/update_icon()
	var/material/M = SSmaterials.all_materials[material_id]
	if(!M)
		name = "ERROR rod"
		log_error("Warning! [src.get_debug_name()] had incorrect material type \"[material_id]\"!")
	else
		name = "[M.name] rod"
		desc = "...they will come."
		desc_extended = "A rod made of [M.name]. Useful for building and crafting."
		icon_state = "[M.icon_state_rod]_[min(CEILING(amount/10,1),amount_max_icon)]"
	return ..()

/obj/item/material/ingot/update_icon()
	var/material/M = SSmaterials.all_materials[material_id]
	if(!M)
		name = "ERROR ingot"
		log_error("Warning! [src.get_debug_name()] had incorrect material type \"[material_id]\"!")
	else
		name = "[M.name] ingot"
		desc_extended = "An ingot of [M.name]. Made by smelting raw ore or alloying."
		icon_state = "[M.icon_state_ingot]_[min(CEILING(amount/10,1),amount_max_icon)]"
	return ..()

/obj/item/material/ore/update_icon()
	. = ..()
	var/material/M = SSmaterials.all_materials[material_id]
	if(!M)
		name = "ERROR ore"
		log_error("Warning! [src.get_debug_name()] had incorrect material type \"[material_id]\"!")
	else
		name = "[M.name] ore"
		color = "#FFFFFF"
		icon_state = M.icon_state_ore
