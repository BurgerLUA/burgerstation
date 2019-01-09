/obj/item/clothing/attack_object(var/atom/caller,var/atom/object,location,control,params)

	if(item_slot && caller == object && istype(caller,/mob/living/advanced/))
		var/mob/living/advanced/A = caller
		if(A.labeled_organs[item_slot])
			var/obj/item/organ/O = A.labeled_organs[item_slot]

			var/obj/inventory/best
			for(var/obj/inventory/I in O.inventories)
				if(!best || (best.priority < I.priority && best.can_wear_object(src)))
					best = I

			if(best)
				return transfer_item(best)

	return ..()