/obj/item/clothing/proc/equip_additional_clothing(var/mob/living/advanced/caller,var/atom/object,location,control,params)

	var/should_deploy = FALSE

	for(var/k in additional_clothing_stored)
		var/obj/item/C = k

		if(!is_clothing(C))
			if(caller.put_in_hands(C,caller.right_item))
				should_deploy = TRUE
			continue

		if(C.loc == C.additional_clothing_parent) //It's not worn, so try to equip.
			if(!C.quick_equip(caller,ignore_held = TRUE,ignore_dynamic=TRUE))
				caller.to_chat(span("notice","You can't toggle \the [C], there is clothing in the way!"))
			should_deploy = TRUE

	if(!should_deploy)
		remove_additonal_clothing()

	return TRUE


/obj/item/clothing/proc/remove_additonal_clothing()

	for(var/k in additional_clothing_stored)
		var/obj/item/C = k
		C.drop_item(src,silent=TRUE)

	return TRUE