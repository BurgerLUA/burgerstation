/obj/item/material/update_icon()
	var/material/M = all_materials[material_id]
	weight = M.weight_per_unit*item_count_current*initial(weight)
	color = M.color
	crafting_id = "[initial(crafting_id)]_[material_id]"
	return ..()

/obj/item/material/sheet/update_icon()
	var/material/M = all_materials[material_id]
	icon_state = "[M.icon_state_sheet]_[min(ceiling(item_count_current,1),item_count_max_icon)]"
	return ..()

/obj/item/material/rod/update_icon()
	var/material/M = all_materials[material_id]
	icon_state = "[M.icon_state_rod]_[min(ceiling(item_count_current,1),item_count_max_icon)]"
	return ..()

/obj/item/material/ingot/update_icon()
	var/material/M = all_materials[material_id]
	icon_state = "[M.icon_state_ingot]_[min(ceiling(item_count_current,1),item_count_max_icon)]"
	return ..()

/obj/item/material/ore/update_icon()
	. = ..()
	var/material/M = all_materials[material_id]
	color = "#FFFFFF"
	icon_state = M.icon_state_ore
	return .