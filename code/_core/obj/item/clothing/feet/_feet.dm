/obj/item/clothing/feet
	worn_layer = LAYER_MOB_CLOTHING_SHOES

/obj/item/clothing/feet/pre_pickup(var/atom/old_location,var/obj/hud/inventory/new_location)

	if(new_location && new_location.worn)
		if(length(protected_limbs))
			protected_limbs = list(new_location.id)
		if(length(hidden_organs))
			hidden_organs = list(new_location.id)

	. = ..()