/obj/item/clothing/click_on_object(var/atom/caller,var/atom/object,location,control,params) //When we attack something with the clothes

	if(is_advanced(caller) && caller == object) //Auto-equip.
		quick_equip(caller)
		return TRUE

	return ..()


/obj/item/clothing/clicked_on_by_object(var/atom/caller,var/atom/object,location,control,params)

	if(is_inventory(object) && is_inventory(src.loc))

		if(delete_on_drop)
			qdel(src)
			return TRUE

		var/obj/hud/inventory/I = src.loc

		if(is_advanced(caller) && (src in I.worn_objects))
			if(equip_additional_clothing(caller,object,location,control,params))
				return TRUE

	return ..()

/obj/item/proc/quick_equip(var/mob/living/advanced/caller)

	var/obj/hud/inventory/best_inventory_wear
	var/obj/hud/inventory/best_inventory_equip

	for(var/obj/hud/inventory/I in caller.inventory)

		if(!I.allow_quick_equip)
			continue

		if(can_be_worn(caller,I) && I.can_wear_object(src) && (!best_inventory_wear || I.priority >= best_inventory_wear.priority))
			best_inventory_wear = I
			continue

		if(can_be_held(caller,I) && I.can_hold_object(src) && (!best_inventory_equip || I.priority >= best_inventory_equip.priority))
			best_inventory_equip = I
			continue

	if(best_inventory_wear)
		return best_inventory_wear.add_object(src)

	if(best_inventory_equip)
		return best_inventory_equip.add_object(src)

	return FALSE


/obj/item/clothing/get_examine_list(var/mob/examiner)

	if(!is_advanced(examiner))
		return ..()

	. = ..()

	if(defense_rating && length(defense_rating) && protected_limbs && length(protected_limbs))
		var/list/armor_list = list()
		for(var/damagetype in defense_rating)
			var/damage_rating = defense_rating[damagetype]
			if(damage_rating)
				armor_list += "[capitalize(damagetype)]: [damage_rating]"

		. += div("notice","<b>Armor:</b> [capitalize(english_list(armor_list))].")
		. += div("notice","<b>Protected Zones:</b> [capitalize(english_list(protected_limbs))].")

	return .