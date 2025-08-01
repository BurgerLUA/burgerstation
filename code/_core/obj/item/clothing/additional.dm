/obj/item/clothing/proc/equip_additional_clothing(var/mob/living/advanced/activator)

	var/should_deploy = FALSE

	for(var/k in additional_clothing_stored)
		var/obj/item/C = k

		if(!istype(C,/obj/item/clothing/)) //Must be a weapon.
			if(activator.put_in_hands(C))
				should_deploy = TRUE
			continue

		if(C.loc == C.additional_clothing_parent) //It's not worn, so try to equip.
			if(!C.quick_equip(activator,ignore_hands=TRUE,ignore_held=FALSE,ignore_dynamic=TRUE))
				activator.to_chat(span("notice","You can't toggle \the [C], there is clothing in the way!"))
			should_deploy = TRUE

	if(!should_deploy)
		remove_additonal_clothing()

	return TRUE


/obj/item/clothing/proc/remove_additonal_clothing()

	for(var/k in additional_clothing_stored)
		var/obj/item/C = k
		C.drop_item(src,silent=TRUE)

	return TRUE

/obj/item/clothing/proc/sync_additional_clothing()

	for(var/obj/item/C as anything in additional_clothing_stored)
		C.color = color
		C.quality = quality
		C.polymorphs = polymorphs
		C.additional_blends = additional_blends
		C.luck = luck
		C.update_sprite()

	return TRUE


/obj/item/clothing/set_quality(var/quality_to_set=100,var/force=FALSE)

	. = ..()

	for(var/obj/item/C as anything in additional_clothing_stored)
		C.set_quality(quality_to_set,force=TRUE)

/obj/item/clothing/set_quality_max(var/quality_to_set=100,var/force=FALSE)

	. = ..()

	for(var/obj/item/C as anything in additional_clothing_stored)
		C.set_quality_max(quality_to_set,force=TRUE)