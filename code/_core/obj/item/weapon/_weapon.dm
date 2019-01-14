/obj/item/weapon/
	var/obj/holder/connected_holder
	var/wielded = FALSE
	var/can_wield = FALSE

/obj/item/weapon/on_drop(var/obj/inventory/I)
	if(connected_holder && is_inventory(connected_holder.loc))
		var/obj/inventory/I2 = connected_holder.loc
		I2.drop_item(connected_holder)

/obj/item/weapon/update_icon()

	if(is_inventory(src.loc) && wielded)
		var/obj/inventory/I = src.loc
		if(I.item_slot & SLOT_HAND_RIGHT)
			pixel_x = 16
		else if(I.item_slot & SLOT_HAND_LEFT)
			pixel_x = -16
		else
			pixel_x = 0
	else
		pixel_x = 0

	visible_message("The [src] is [wielded].")

	..()

/obj/item/weapon/click_self(var/atom/caller)
	if(wielded)
		wielded = FALSE
		update_icon()
		return TRUE

	..()

/obj/item/weapon/clicked_by_object(var/mob/caller as mob,var/atom/object,location,control,params) //The src was clicked on by the object
	if(can_wield && object && is_inventory(object) && src && src.loc && is_inventory(src.loc))

		var/obj/inventory/offhand_slot = object

		if(offhand_slot.get_top_held_object())
			return

		wielded = !wielded

		if(wielded)
			connected_holder = new(offhand_slot,src)
			offhand_slot.add_held_object(connected_holder,FALSE,TRUE)
			caller << connected_holder.icon
			caller << connected_holder.icon_state
		else
			if(connected_holder)
				connected_holder.loc = null
				del(connected_holder)
				connected_holder = null

		update_icon()

	return ..()