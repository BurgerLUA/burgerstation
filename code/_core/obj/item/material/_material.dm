/obj/item/material/
	name = "material"
	desc = "I am error."
	icon = 'icons/obj/items/material.dmi'
	icon_state = "sheet"

	item_count_current = 1
	item_count_max = 50
	item_count_max_icon = 3

	weight = WEIGHT_1

	crafting_id = "glitch"

/obj/item/material/update_icon()
	icon_state = "[initial(icon_state)]_[min(ceiling(item_count_current/10,1),item_count_max_icon)]"
	weight = initial(weight)*item_count_current
	return ..()

/obj/item/material/steel
	name = "steel sheets"
	desc = "The basic building material."
	crafting_id = "sheet_steel"
	color = "#A0A0A0"

/obj/item/material/steel/spawn_50/on_spawn()
	item_count_current = 50
	update_icon()

/obj/item/material/steel/spawn_25/on_spawn()
	item_count_current = 25
	update_icon()

/obj/item/material/steel/spawn_10/on_spawn()
	item_count_current = 10
	update_icon()

/obj/item/material/steel/clicked_on_by_object(var/mob/caller,object,location,control,params)

	INTERACT_CHECK

	if(is_inventory(object))
		var/obj/hud/inventory/I = object
		var/obj/item/material/M = new src.type(get_turf(src))
		M.update_icon()
		M.transfer_item(I)
		src.item_count_current -= 1
		if(src.item_count_current <= 0)
			qdel(src)
			return TRUE
		update_icon()
		return TRUE

	if(!istype(object,/obj/item/material/))
		return ..()

	var/obj/item/material/M = object
	if(M.crafting_id != src.crafting_id)
		return ..()

	var/amount_to_transfer = min(M.item_count_max - M.item_count_current,src.item_count_current)

	if(!amount_to_transfer)
		return TRUE

	src.item_count_current -= amount_to_transfer
	M.item_count_current += amount_to_transfer

	caller.to_chat(span("notice","You transfer [amount_to_transfer] sheet\s between the stacks. You now have [M.item_count_current]."))

	M.update_icon()

	if(src.item_count_current <= 0)
		qdel(src)
		return TRUE

	src.update_icon()

	return TRUE