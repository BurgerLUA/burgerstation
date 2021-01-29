/obj/item/clothing/click_on_object(var/mob/caller,var/atom/object,location,control,params) //When we attack something with the clothes

	if(is_advanced(caller) && caller == object) //Auto-equip.
		//No interaction delay needed.
		quick_equip(caller,ignore_held=TRUE,ignore_dynamic=TRUE)
		return TRUE

	return ..()


/obj/item/clothing/clicked_on_by_object(var/mob/caller,var/atom/object,location,control,params)

	if(length(additional_clothing_stored) && is_advanced(caller) && is_inventory(object) && is_inventory(src.loc))
		var/obj/hud/inventory/I = src.loc
		if(src in I.contents)
			INTERACT_CHECK
			INTERACT_CHECK_OBJECT
			INTERACT_DELAY(5)
			equip_additional_clothing(caller,object,location,control,params)
			return TRUE

	return ..()

/obj/item/proc/quick_equip(var/mob/living/advanced/caller,var/ignore_hands = FALSE,var/ignore_worn=FALSE,var/ignore_held=FALSE,var/ignore_dynamic=FALSE,var/debug=FALSE,var/silent=FALSE)

	var/obj/hud/inventory/best_inventory_wear
	var/obj/hud/inventory/best_inventory_equip

	for(var/k in caller.inventory)
		var/obj/hud/inventory/I = k
		if(I.click_flags && ignore_hands)
			continue
		if(!I.allow_quick_equip)
			continue
		if(!ignore_worn && I.worn && can_be_worn(caller,I) && I.can_slot_object(src) && (!best_inventory_wear || I.priority >= best_inventory_wear.priority))
			best_inventory_wear = I
			continue
		if(istype(I,/obj/hud/inventory/dynamic))
			if(!ignore_dynamic && can_be_held(caller,I) && I.can_slot_object(src) && (!best_inventory_equip || I.priority >= best_inventory_equip.priority))
				best_inventory_equip = I
				continue
		else
			if(!ignore_held && can_be_held(caller,I) && I.can_slot_object(src) && (!best_inventory_equip || I.priority >= best_inventory_equip.priority))
				best_inventory_equip = I
				continue


	if(best_inventory_wear)
		if(debug) log_debug("(WEAR) Best inventory found for [caller.get_debug_name()]: [best_inventory_wear.get_debug_name()].")
		return best_inventory_wear.add_object(src,silent=silent)

	if(best_inventory_equip)
		if(debug) log_debug("(EQUIP) Best inventory found for [caller.get_debug_name()]: [best_inventory_equip.get_debug_name()].")
		return best_inventory_equip.add_object(src,silent=silent)

	return FALSE


/obj/item/clothing/get_examine_list(var/mob/examiner)

	. = ..()

	if(speed_bonus != 0)
		if(speed_bonus > 0)
			. += div("notice","<b>Speed Bonus:</b> [speed_bonus*100]%.")
		else
			. += div("notice","<b>Speed Penalty:</b> [speed_bonus*100]%.")

	var/list/defense_rating_to_print = get_defense_rating()

	if(defense_rating_to_print && length(defense_rating_to_print) && protected_limbs && length(protected_limbs))
		var/list/armor_list = list()
		for(var/damagetype in defense_rating_to_print)
			var/damage_rating = defense_rating_to_print[damagetype]
			if(IS_INFINITY(damage_rating))
				armor_list += "[capitalize(damagetype)]: INFINITE"
			else if(damage_rating)
				damage_rating = FLOOR(damage_rating*(src.quality/100),1)
				armor_list += "[capitalize(damagetype)]: [damage_rating]"
		. += div("notice","<b>Armor:</b> [capitalize(english_list(armor_list))].")
		. += div("notice","<b>Protected Zones:</b> [capitalize(english_list(protected_limbs))].")

	return .