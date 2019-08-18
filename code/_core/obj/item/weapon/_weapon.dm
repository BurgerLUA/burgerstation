/obj/item/weapon/
	var/wielded = FALSE
	var/can_wield = FALSE
	var/wield_only = FALSE //Set to true if you can only attack with this while wielded.


	var/open = FALSE //Mainly used for ranged weapons, can be used for melee I guess

	var/override_icon_state = FALSE
	var/override_icon_state_held = FALSE

	ignore_other_slots = TRUE

	var/prefix_id //The weapon's prefix, if any.

/obj/item/weapon/update_icon()

	if(!override_icon_state_held)
		if(wielded)
			icon_state_held_left = "wielded_left"
			icon_state_held_right = "wielded_right"
		else
			icon_state_held_left = initial(icon_state_held_left)
			icon_state_held_right = initial(icon_state_held_right)

		var/open_text = open ? "_open" : ""
		icon_state_held_left = "[icon_state_held_left][open_text]"
		icon_state_held_right = "[icon_state_held_right][open_text]"

	if(!override_icon_state)
		if(open)
			icon_state = "[initial(icon_state)]_open"
		else
			icon_state = initial(icon_state)

	if(is_inventory(src.loc))
		var/obj/hud/inventory/I = src.loc
		if(wielded)
			if(I.item_slot & SLOT_HAND_RIGHT)
				pixel_x = 16
			else if(I.item_slot & SLOT_HAND_LEFT)
				pixel_x = -16
			else
				pixel_x = 0
		else
			pixel_x = 0

		if(I.owner)
			I.owner.update_icon()

	else
		pixel_x = 0

	..()

/obj/item/weapon/click_on_object(var/mob/caller as mob,var/atom/object,location,control,params)

	if(wield_only && !wielded)
		caller.to_chat(span("notice","You can only attack with this when wielded! (CTRL+CLICK)"))
		return TRUE

	return src.attack(caller,object,params)

/obj/item/weapon/click_self(var/mob/caller)
	return TRUE

/obj/item/weapon/clicked_by_object(var/mob/caller as mob,var/atom/object,location,control,params) //The src was clicked on by the object

	if(can_wield && object && is_inventory(object) && src && src.loc && is_inventory(src.loc) && caller.movement_flags & MOVEMENT_CROUCHING)

		var/obj/hud/inventory/offhand_slot = object
		var/obj/hud/inventory/main_slot = src.loc

		wielded = !wielded

		if(wielded)
			offhand_slot.parent_inventory = main_slot
			main_slot.child_inventory = offhand_slot
			offhand_slot.update_icon()
		else
			main_slot.child_inventory = null
			offhand_slot.parent_inventory = null
			offhand_slot.update_icon()

		caller.to_chat(span("notice","You hold \the [src] with [wielded ? "two hands" : "one hand"]."))
		update_icon()
		return TRUE

	return ..()

/obj/item/weapon/on_drop(var/obj/hud/inventory/I)
	wielded = FALSE
	if(I.child_inventory)
		I.child_inventory.parent_inventory = null
		I.child_inventory.update_icon()
		I.child_inventory = null
	update_icon()
	..()

/obj/item/weapon/proc/can_parry(var/atom/attacker,var/atom/attacking_weapon,var/atom/victim,var/damagetype/DT,var/allow_parry_counter)
	return FALSE

/obj/item/weapon/proc/can_block(var/atom/attacker,var/atom/attacking_weapon,var/atom/victim,var/damagetype/DT,var/allow_parry_counter)
	return FALSE