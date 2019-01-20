/obj/item/clothing/click_on_object(var/atom/caller,var/atom/object,location,control,params) //When we attack something with the clothes

	if(is_advanced(object))
		var/mob/living/advanced/M = object

		var/obj/inventory/best_inventory

		for(var/obj/inventory/I in M.inventory)
			if(!best_inventory)
				best_inventory = I
				continue

			if(I.can_wear_object(src) && I.priority >= best_inventory.priority)
				best_inventory = I
				continue

		if(best_inventory)
			return src.transfer_item(best_inventory)

	return TRUE