/obj/item/material/clicked_on_by_object(var/mob/caller,object,location,control,params)

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