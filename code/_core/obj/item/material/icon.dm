/obj/item/material/update_icon()
	var/material/M = SSmaterials.all_materials[material_id]
	weight = M.weight_per_unit*item_count_current*initial(weight)
	color = M.color
	material = list()
	material[material_id] = item_count_current * initial(weight) * 1000
	return ..()

/obj/item/material/sheet/update_icon()
	var/material/M = SSmaterials.all_materials[material_id]
	name = "[M.name] sheet"
	icon_state = "[M.icon_state_sheet]_[min(CEILING(item_count_current/10,1),item_count_max_icon)]"
	return ..()

/obj/item/material/rod/update_icon()
	var/material/M = SSmaterials.all_materials[material_id]
	name = "[M.name] rod"
	icon_state = "[M.icon_state_rod]_[min(CEILING(item_count_current/10,1),item_count_max_icon)]"
	return ..()

/obj/item/material/ingot/update_icon()
	var/material/M = SSmaterials.all_materials[material_id]
	name = "[M.name] ingot"
	icon_state = "[M.icon_state_ingot]_[min(CEILING(item_count_current/10,1),item_count_max_icon)]"
	return ..()

/obj/item/material/ore/update_icon()
	. = ..()
	var/material/M = SSmaterials.all_materials[material_id]
	color = "#FFFFFF"
	icon_state = M.icon_state_ore
	return .