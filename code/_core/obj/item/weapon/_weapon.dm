/obj/item/weapon/

	can_rename = TRUE

	var/wield_only = FALSE //Set to true if you can only attack with this while wielded.


	var/open = FALSE //Mainly used for ranged weapons, can be used for melee I guess
	var/open_icon = TRUE //Does the weapon have an icon for it being open?

	var/override_icon_state = FALSE
	var/override_icon_state_held = FALSE
	enable_held_icon_states = TRUE

	ignore_other_slots = TRUE

	var/prefix_id //The weapon's prefix, if any.

	var/enchantment/enchantment

	can_wear = TRUE
	item_slot = -1

	//var/weapon_tier = 0

	uses_until_condition_fall = 100

	has_quick_function = TRUE

	var/bypass_balance_check = FALSE //Set to true to ignore warnings about mismatched tiers in terms of balance.
	var/tier = -1 //-1 means not set.
	var/tier_type = "weapon"

/obj/item/weapon/Finalize()
	. = ..()
	if(tier == -1 && SSbalance && SSbalance.initialized && isnum(SSbalance.stored_tier[type]))
		tier = SSbalance.stored_tier[type]

/obj/item/weapon/get_examine_list(var/mob/examiner)
	. = ..()
	. += div("rarity center","Tier [tier] [tier_type].")
	if(enchantment)
		. += div("notice","It is enchanted with <b>[enchantment.name]</b>")
		. += div("notice","The enchantment has [enchantment.charge] charge left ([FLOOR(enchantment.charge/enchantment.cost,1)] uses).")

/obj/item/weapon/quick(var/mob/caller,var/atom/object,location,params)

	if(!is_advanced(caller) || !is_inventory(src.loc))
		return FALSE

	var/mob/living/advanced/A = caller
	var/obj/hud/inventory/I = src.loc
	var/obj/item/belt_storage = I.loc
	var/real_number = I.id ? text2num(copytext(I.id,-1)) : 0

	var/put_in_left = real_number > belt_storage.dynamic_inventory_count*0.5

	return A.put_in_hands(src,left = put_in_left)

/* Price calculation is hard.
/obj/item/weapon/get_base_value()

	if(!damage_type)
		return ..()

	var/damagetype/D = all_damage_types[damage_type]

	if(!D)
		return ..()

	return D.calculate_value(src)
*/

/obj/item/weapon/can_feed(var/mob/caller,var/atom/target)
	return FALSE

/obj/item/weapon/PostInitialize()
	. = ..()
	if(can_wear && item_slot == -1)
		if(size <= 3)
			item_slot = SLOT_GROIN_BELT
		else
			item_slot = SLOT_TORSO_BACK

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

/obj/item/weapon/on_drop(var/obj/hud/inventory/old_inventory,var/atom/new_loc,var/silent=FALSE)
	wielded = FALSE
	if(old_inventory.child_inventory)
		old_inventory.child_inventory.parent_inventory = null
		old_inventory.child_inventory.update_sprite()
		old_inventory.child_inventory = null
	update_sprite()
	return ..()

/obj/item/weapon/save_item_data(var/save_inventory = TRUE)
	. = ..()
	if(length(polymorphs)) .["polymorphs"] = polymorphs
	if(enchantment)
		.["enchantment"] = list()
		.["enchantment"]["enchantment_type"] = enchantment.type
		.["enchantment"]["strength"] = enchantment.strength
		.["enchantment"]["charge"] = enchantment.charge
		.["enchantment"]["cost"] = enchantment.cost

/obj/item/weapon/load_item_data_pre(var/mob/living/advanced/player/P,var/list/object_data)
	. = ..()
	if(object_data["polymorphs"]) polymorphs = object_data["polymorphs"]
	if(object_data["enchantment"] && object_data["enchantment"]["enchantment_type"])
		var/possible_enchantment = text2path(object_data["enchantment"]["enchantment_type"])
		if(possible_enchantment)
			enchantment = new possible_enchantment
			enchantment.strength = object_data["enchantment"]["strength"]
			enchantment.charge = object_data["enchantment"]["charge"]
			enchantment.cost = object_data["enchantment"]["cost"]