/obj/item/clothing/click_on_object(var/atom/caller,var/atom/object,location,control,params) //When we attack something with the clothes

	if(caller == object && is_advanced(object)) //Auto-equip.
		quick_equip(caller)
		return TRUE

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


/obj/item/clothing/get_examine_text(var/mob/examiner)

	if(!is_advanced(examiner))
		return ..()

	. = ..()

	if(armor_rating && length(armor_rating) && protected_limbs && length(protected_limbs))
		. += div("notice bold","Armor:")
		for(var/damagetype in armor_rating)
			var/damage_rating = armor_rating[damagetype]
			. += div("notice",damagetype + ": " + damage_rating)

		. += div("notice bold","Protected Parts") + div("notice",english_list(protected_limbs))

	return .