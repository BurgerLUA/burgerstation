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

	var/list/enchantment_whitelist[] //A whitelist of ["/enchantment/path"] or [ALL] of enchants allowed on the weapon E.G. "/enchantment/fire". Path should be a string.

	can_wear = TRUE
	item_slot = -1

	uses_until_condition_fall = 100

	has_quick_function = TRUE

	var/bypass_balance_check = FALSE //Set to true to ignore warnings about mismatched tiers in terms of balance.

	tier = -1 //Automatic generation.

	block_sound = 'sound/effects/impacts/shield_metal_weak.ogg'

	var/company_type

	var/obj/item/spellswap/stored_spellswap

/obj/item/weapon/Finalize()
	. = ..()
	if(tier == -1)
		if(SSbalance && SSbalance.initialized && isnum(SSbalance.stored_tier[type]))
			tier = SSbalance.stored_tier[type]
		else
			tier = 1

/obj/item/weapon/get_examine_list(var/mob/examiner)
	. = ..()
	if(enchantment)
		. += div("notice","It is enchanted with <b>[enchantment.name]</b>")
		. += div("notice","The enchantment has [enchantment.charge] charge left ([FLOOR(enchantment.charge/enchantment.cost,1)] uses).")

/obj/item/weapon/quick(var/mob/caller,var/atom/object,location,params)

	if(!is_advanced(caller) || !is_inventory(src.loc))
		return FALSE

	var/mob/living/advanced/A = caller

	return A.put_in_hands(src,params)


/obj/item/weapon/get_base_value()

	if(!SSbalance || !SSbalance.stored_value_weapons[src.type])
		return ..()

	return SSbalance.stored_value_weapons[src.type]

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

/obj/item/weapon/on_drop(var/obj/hud/inventory/old_inventory,var/silent=FALSE)
	wielded = FALSE
	if(old_inventory.child_inventory)
		old_inventory.child_inventory.parent_inventory = null
		old_inventory.child_inventory.update_sprite()
		old_inventory.child_inventory = null
	update_sprite()
	. = ..()

/obj/item/weapon/clicked_on_by_object(mob/caller,atom/object,location,control,params)
	if(istype(object,/obj/item/soulgem) && enchantment)
		var/obj/item/soulgem/G = object
		if(G.total_charge > 0 && enchantment.charge < enchantment.max_charge)
			var/chargediff = min(G.total_charge,(enchantment.max_charge - enchantment.charge)) 
			enchantment.charge += chargediff
			G.total_charge -= chargediff
			if(!caller.is_player_controlled())
				CRASH("How the flying fuck is a mob smart enough to recharge their enchanted weapon![caller.get_debug_name()] did it!")
			var/mob/living/pcaller = caller //This is stupid and bad.
			pcaller.add_skill_xp(SKILL_MAGIC_ENCHANTING,chargediff*0.5)
			if(G.total_charge <= 0)
				caller.visible_message(span("notice","\The [caller.name] siphons some energy from \the [G.name] to recharge \the [src.name],shattering it!"),span("notice","You recharge the enchantment on \the [src.name] using the [G.name], shattering it!"))
				qdel(G)
			else
				caller.visible_message(span("notice","\The [caller.name] siphons some energy from \the [G.name] to recharge \the [src.name]"),span("notice","You recharge the enchantment on \the [src.name] using the [G.name]"))
			return TRUE
	. = ..()
/obj/item/weapon/save_item_data(var/mob/living/advanced/player/P,var/save_inventory = TRUE,var/died=FALSE)
	. = ..()
	if(length(polymorphs)) .["polymorphs"] = polymorphs
	if(enchantment)
		.["enchantment"] = list()
		.["enchantment"]["enchantment_type"] = enchantment.type
		.["enchantment"]["strength"] = enchantment.strength
		.["enchantment"]["charge"] = enchantment.charge
		.["enchantment"]["cost"] = enchantment.cost
		.["enchantment"]["max_charge"] = enchantment.max_charge
	if(stored_spellswap)
		SAVEATOM("stored_spellswap")

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
			enchantment.max_charge = object_data["enchantment"]["max_charge"]
	if(object_data["stored_spellswap"])
		LOADATOM("stored_spellswap")

