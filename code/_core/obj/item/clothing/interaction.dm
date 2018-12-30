/obj/item/clothing/use_item_on(var/atom/caller,var/atom/object,location,control,params)

	if(item_slot && caller == object && istype(caller,/mob/living/advanced/))
		var/mob/living/advanced/A = caller
		if(A.labeled_organs[item_slot])
			var/obj/item/organ/O = A.labeled_organs[item_slot]
			if(O.inventory)
				return transfer_item(O.inventory)

	return ..()