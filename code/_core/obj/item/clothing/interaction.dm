/obj/item/clothing/click_on_object(var/mob/caller,var/atom/object,location,control,params) //When we attack something with the clothes

	if(is_advanced(caller) && caller == object) //Auto-equip.
		if(delete_on_drop)
			return TRUE
		quick_equip(caller,ignore_held=TRUE)
		return TRUE

	return ..()


/obj/item/clothing/clicked_on_by_object(var/mob/caller,var/atom/object,location,control,params)

	if(is_inventory(object) && is_inventory(src.loc))

		if(delete_on_drop)
			qdel(src)
			return TRUE

		var/obj/hud/inventory/I = src.loc

		if(is_advanced(caller) && (src in I.worn_objects))
			if(equip_additional_clothing(caller,object,location,control,params))
				return TRUE

	return ..()

/obj/item/proc/quick_equip(var/mob/living/advanced/caller,var/ignore_hands = FALSE,var/ignore_worn=FALSE,var/ignore_held=FALSE,var/debug=FALSE)

	var/obj/hud/inventory/best_inventory_wear
	var/obj/hud/inventory/best_inventory_equip

	for(var/k in caller.inventory)
		var/obj/hud/inventory/I = k
		if(I.click_flags && ignore_hands)
			continue
		if(!I.allow_quick_equip)
			continue
		if(!ignore_worn && can_be_worn(caller,I) && I.can_wear_object(src) && (!best_inventory_wear || I.priority >= best_inventory_wear.priority))
			best_inventory_wear = I
			continue
		if(!ignore_held && can_be_held(caller,I) && I.can_hold_object(src) && (!best_inventory_equip || I.priority >= best_inventory_equip.priority))
			best_inventory_equip = I
			continue

	if(best_inventory_wear)
		if(debug) LOG_DEBUG("(WEAR) Best inventory found for [caller.get_debug_name()]: [best_inventory_wear.get_debug_name()].")
		return best_inventory_wear.add_object(src)

	if(best_inventory_equip)
		if(debug) LOG_DEBUG("(EQUIP) Best inventory found for [caller.get_debug_name()]: [best_inventory_equip.get_debug_name()].")
		return best_inventory_equip.add_object(src)

	return FALSE


/obj/item/clothing/get_examine_list(var/mob/examiner)

	if(!is_advanced(examiner))
		return ..()

	. = ..()

	var/list/defense_rating_to_print = get_defense_rating()

	if(defense_rating_to_print && length(defense_rating_to_print) && protected_limbs && length(protected_limbs))
		var/list/armor_list = list()
		for(var/damagetype in defense_rating_to_print)
			var/damage_rating = defense_rating_to_print[damagetype]
			if(damage_rating)
				armor_list += "[capitalize(damagetype)]: [damage_rating]"

		. += div("notice","<b>Armor:</b> [capitalize(english_list(armor_list))].")
		. += div("notice","<b>Protected Zones:</b> [capitalize(english_list(protected_limbs))].")

	return .