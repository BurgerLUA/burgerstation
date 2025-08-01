/obj/item/clothing/click_on_object(var/mob/activator,var/atom/object,location,control,params) //When we attack something with the clothes

	if(is_advanced(activator) && activator == object) //Auto-equip.
		//No interaction delay needed.
		quick_equip(activator,ignore_held=TRUE,ignore_dynamic=TRUE)
		return TRUE

	return ..()


/obj/item/clothing/click_self(var/mob/activator,location,control,params)

	if(length(additional_clothing_stored) && is_advanced(activator) && is_inventory(src.loc))
		var/obj/hud/inventory/I = src.loc
		if(I.worn)
			INTERACT_CHECK
			INTERACT_DELAY(5)
			equip_additional_clothing(activator)
			return TRUE

	. = ..()

/obj/item/proc/quick_equip(var/mob/living/advanced/activator,var/ignore_hands = FALSE,var/ignore_worn=FALSE,var/ignore_held=FALSE,var/ignore_dynamic=FALSE,var/debug=FALSE,var/silent=FALSE)

	var/obj/hud/inventory/best_inventory_wear
	var/obj/hud/inventory/best_inventory_equip

	for(var/k in activator.inventories_by_id)
		var/obj/hud/inventory/I = activator.inventories_by_id[k]
		if(!I || I.qdeleting || !I.loc || I.loc.qdeleting || !I.allow_quick_equip)
			continue
		if((I.click_flags & (LEFT_HAND | RIGHT_HAND)) && ignore_hands)
			continue
		if(!ignore_worn && I.worn && (!best_inventory_wear || I.priority >= best_inventory_wear.priority) && can_be_worn(activator,I) && I.can_slot_object(src))
			best_inventory_wear = I
			continue
		if(I.should_add_to_advanced) //Non-dynamic
			if(!ignore_held && (!best_inventory_equip || I.priority >= best_inventory_equip.priority) && can_be_held(activator,I) && I.can_slot_object(src))
				best_inventory_equip = I
				continue
		else
			if(!ignore_dynamic && (!best_inventory_equip || I.priority >= best_inventory_equip.priority) && can_be_held(activator,I) && I.can_slot_object(src))
				best_inventory_equip = I
				continue

	if(best_inventory_wear)
		if(debug) log_debug("(WEAR) Best inventory found for [activator.get_debug_name()]: [best_inventory_wear.get_debug_name()].")
		return best_inventory_wear.add_object(src,silent=silent)

	if(best_inventory_equip)
		if(debug) log_debug("(EQUIP) Best inventory found for [activator.get_debug_name()]: [best_inventory_equip.get_debug_name()].")
		return best_inventory_equip.add_object(src,silent=silent)

	return FALSE


/obj/item/clothing/get_examine_list(var/mob/examiner)

	. = ..()

	if(speed_bonus != 0)
		if(speed_bonus > 0)
			. += div("notice","<b>Speed Bonus:</b> [speed_bonus*100]%.")
		else
			. += div("notice","<b>Speed Penalty:</b> [speed_bonus*100]%.")

	var/armor/A = ARMOR(src.armor)
	if(A)
		var/list/defense_rating_to_print = A.defense_rating
		if(defense_rating_to_print && length(defense_rating_to_print) && protected_limbs && length(protected_limbs))
			var/list/armor_list = list()
			for(var/damagetype in defense_rating_to_print)
				var/damage_rating = defense_rating_to_print[damagetype]
				if(IS_INFINITY(damage_rating))
					armor_list += "[capitalize(damagetype)]: IMMUNITY"
				else if(damage_rating)
					if(damage_rating > 0)
						damage_rating = FLOOR(damage_rating*get_quality_mod(),1)
					armor_list += "[capitalize(damagetype)]: [damage_rating]"
			. += div("notice","<b>Armor:</b> [capitalize(english_list(armor_list))].")
			. += div("notice","<b>Protected Zones:</b> [capitalize(english_list(protected_limbs))].")

