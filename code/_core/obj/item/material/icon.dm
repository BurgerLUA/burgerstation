/obj/item/material/update_icon()
	var/material/M = SSmaterials.all_materials[material_id]
	color = M.color
	material = list()
	material[material_id] = item_count_current * 1000
	return ..()

/obj/item/material/sheet/update_icon()
	var/material/M = SSmaterials.all_materials[material_id]
	if(!M)
		name = "ERROR sheet"
		log_error("Warning! [src.get_debug_name()] had incorrect material type \"[material_id]\"!")
	else
		name = "[M.name] sheet"
		icon_state = "[M.icon_state_sheet]_[min(CEILING(item_count_current/10,1),item_count_max_icon)]"
	return ..()

/obj/item/material/rod/update_icon()
	var/material/M = SSmaterials.all_materials[material_id]
	if(!M)
		name = "ERROR rod"
		log_error("Warning! [src.get_debug_name()] had incorrect material type \"[material_id]\"!")
	else
		name = "[M.name] rod"
		icon_state = "[M.icon_state_rod]_[min(CEILING(item_count_current/10,1),item_count_max_icon)]"
	return ..()

/obj/item/material/ingot/update_icon()
	var/material/M = SSmaterials.all_materials[material_id]
	if(!M)
		name = "ERROR ingot"
		log_error("Warning! [src.get_debug_name()] had incorrect material type \"[material_id]\"!")
	else
		name = "[M.name] ingot"
		icon_state = "[M.icon_state_ingot]_[min(CEILING(item_count_current/10,1),item_count_max_icon)]"
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
	return .