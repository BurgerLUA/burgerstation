/obj/item/weapon/
	//var/wielded = FALSE
	//var/can_wield = FALSE
	var/wield_only = FALSE //Set to true if you can only attack with this while wielded.


	var/open = FALSE //Mainly used for ranged weapons, can be used for melee I guess
	var/open_icon = TRUE //Does the weapon have an icon for it being open?

	var/override_icon_state = FALSE
	var/override_icon_state_held = FALSE

	ignore_other_slots = TRUE

	var/prefix_id //The weapon's prefix, if any.

	quick_function_type = FLAG_QUICK_TOGGLE

	attack_delay = 10
	attack_delay_max = 10

/obj/item/weapon/update_icon()

	var/open_text = open_icon && open ? "_open" : ""

	if(!override_icon_state_held)
		if(wielded)
			icon_state_held_left = "wielded_left"
			icon_state_held_right = "wielded_right"
		else
			icon_state_held_left = initial(icon_state_held_left)
			icon_state_held_right = initial(icon_state_held_right)

		icon_state_held_left = "[icon_state_held_left][open_text]"
		icon_state_held_right = "[icon_state_held_right][open_text]"
		update_held_icon()

	if(!override_icon_state)
		icon_state = "[initial(icon_state)][open_text]"

	return ..()

/obj/item/weapon/click_on_object(var/mob/caller as mob,var/atom/object,location,control,params)

	if(wield_only && !wielded && !is_inventory(object))
		caller.to_chat(span("notice","You can only attack with this when wielded! (CTRL+CLICK)"))
		return TRUE

	return ..()

/*
/obj/item/weapon/click_self(var/mob/caller)
	return TRUE
*/

/obj/item/weapon/on_drop(var/obj/hud/inventory/I)
	wielded = FALSE
	if(I.child_inventory)
		I.child_inventory.parent_inventory = null
		I.child_inventory.update_sprite()
		I.child_inventory = null
	update_sprite()
	return ..()