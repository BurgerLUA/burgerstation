/obj/item/clothing/click_on_object(var/atom/caller,var/atom/object,location,control,params) //When we attack something with the clothes

	if(caller == object && is_advanced(object)) //Auto-equip.
		return quick_equip(caller)

	return FALSE


/obj/item/clothing/proc/quick_equip(var/mob/living/advanced/caller)

	var/obj/inventory/best_inventory

	for(var/obj/inventory/I in caller.inventory)
		if(!best_inventory)
			best_inventory = I
			continue

		if(I.can_wear_object(src) && I.priority >= best_inventory.priority)
			best_inventory = I
			continue

	if(best_inventory)
		return src.transfer_item(best_inventory)

	return FALSE

