/obj/item/clothing/proc/equip_additional_clothing(var/mob/living/advanced/caller,var/atom/object,location,control,params)

	if(!length(additional_clothing))
		return FALSE

	var/should_deploy = FALSE

	for(var/obj/item/C in additional_clothing_stored)

		if(!is_clothing(C))
			if(caller.put_in_hands(C,caller.right_item))
				should_deploy = TRUE
			continue

		if(C.loc == C.additional_clothing_parent) //It's not worn, so try to equip.
			if(!C.quick_equip(caller))
				caller.to_chat(span("notice","You can't toggle \the [C], there is clothing in the way!"))
			should_deploy = TRUE

	if(!should_deploy)
		remove_additonal_clothing()

	return TRUE


/obj/item/clothing/proc/remove_additonal_clothing()

	for(var/obj/item/C in additional_clothing_stored)
		C.drop_item(src)

	return TRUE