/obj/item/clothing/belt
	name = "belt"
	worn_layer = LAYER_MOB_CLOTHING_BELT
	item_slot = SLOT_GROIN_BELT

	protected_limbs = list(BODY_GROIN)

	item_slot_layer = 3

	dynamic_inventory_type = /obj/hud/inventory/dynamic/belt


/obj/item/clothing/belt/pre_pickup(var/atom/old_location,var/obj/hud/inventory/new_location)

	. = ..()

	var/old_check = istype(old_location,/obj/hud/inventory/organs/groin_o)
	var/new_check = istype(new_location,/obj/hud/inventory/organs/groin_o)

	if(old_check || new_check)
		for(var/obj/hud/inventory/dynamic/belt/I in inventories)
			if(old_check && I.assoc_slot) //We're being removed
				I.assoc_slot.clear_object()
				I.assoc_slot = null
			if(new_check)
				var/mob/living/advanced/owner = new_location.owner
				if(owner && owner.client)
					var/suffix = copytext(I.id,-1)
					var/obj/hud/button/slot/S = owner.slot_buttons[suffix]
					if(S)
						I.assoc_slot = S
						var/obj/item/O = I.get_top_object()
						if(O)
							I.assoc_slot.store_object(O)
					else
						log_error("Warning: [owner.get_debug_name()] didn't have a slot button [suffix] initialized.")



