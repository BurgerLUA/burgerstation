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

	var/list/enchantment_whitelist //Set to null to disable whitelist and allow all.
	var/list/enchantment_blacklist //Set to null to disable blacklist and allow all.

	item_slot = -1

	uses_until_condition_fall = 100

	has_quick_function = TRUE

	var/bypass_balance_check = FALSE //Set to true to ignore warnings about mismatched tiers in terms of balance.

	tier = -1 //Automatic generation.

	block_sound = 'sound/effects/impacts/shield_metal_weak.ogg'

	var/company_type

	var/obj/item/spellswap/stored_spellswap

	thrown_bounce_modifier = 0.25

	var/upgrade_count = 0 //The amount of times this weapon has been upgraded. Maximum 6 times.

	quality = 100

/obj/item/weapon/Finalize()
	. = ..()
	if(SSbalance && SSbalance.initialized && isnum(SSbalance.stored_tier[type]))
		if(tier_type && SSbalance.stored_tier_max[tier_type] && SSbalance.stored_tier_max[tier_type] < 6)
			tier = (SSbalance.stored_tier[type] / SSbalance.stored_tier_max[tier_type]) * 6
		else
			tier = SSbalance.stored_tier[type]

/obj/item/weapon/get_examine_list(var/mob/examiner)
	. = ..()
	if(upgrade_count >= 1)
		if(upgrade_count >= 2)
			. += div("rarity legendary",repeat_text("★",upgrade_count-1))
		else
			. += div("rarity legendary","★")

/obj/item/weapon/get_examine_details_list(var/mob/examiner)
	. = ..()
	if(enchantment)
		. += div("notice","It is enchanted with <b>[enchantment.name] \Roman[enchantment.strength]</b>")
		. += div("notice","The enchantment has [enchantment.charge] charge left ([FLOOR(enchantment.charge/enchantment.cost,1)] uses).")

/obj/item/weapon/quick(var/mob/caller,var/atom/object,location,params)

	if(!is_advanced(caller) || !is_inventory(src.loc))
		return FALSE

	var/mob/living/advanced/A = caller

	return A.put_in_hands(src,params)


/obj/item/weapon/get_base_value()

	if(!SSbalance || !SSbalance.stored_value[src.type])
		return ..()

	. = SSbalance.stored_value[src.type]

	if(upgrade_count >= 1)
		. *= 1 + upgrade_count * (upgrade_count-1) * 0.5

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

/obj/item/weapon/on_unequip(var/obj/hud/inventory/old_inventory,var/silent=FALSE)
	wielded = FALSE
	if(old_inventory.child_inventory)
		old_inventory.child_inventory.parent_inventory = null
		old_inventory.child_inventory.update_sprite()
		old_inventory.child_inventory = null
	update_sprite()
	. = ..()

/obj/item/weapon/clicked_on_by_object(mob/caller,atom/object,location,control,params)

	if(enchantment && istype(object,/obj/item/soulgem))
		INTERACT_CHECK
		INTERACT_DELAY(20)
		var/obj/item/soulgem/G = object
		if(enchantment.charge >= enchantment.max_charge)
			caller.to_chat(span("warning","\The [src.name] is already fully recharged!"))
			return TRUE
		if(G.total_charge <= 0)
			caller.to_chat(span("warning","\The [G.name] is empty and devoid of charge!"))
			return TRUE
		var/chargediff = min(G.total_charge,(enchantment.max_charge - enchantment.charge))
		enchantment.charge += chargediff
		G.total_charge -= chargediff
		var/mob/living/L = caller
		L.add_skill_xp(SKILL_SUMMONING,chargediff*0.0025)
		if(G.total_charge <= 0 && !G.do_not_consume)
			caller.visible_message(span("notice","\The [caller.name] siphons some energy from \the [G.name] to recharge \the [src.name], consuming it!"),span("notice","You recharge the enchantment on \the [src.name] using the [G.name], consuming it!"))
			qdel(G)
		else
			caller.visible_message(span("notice","\The [caller.name] siphons some energy from \the [G.name] to recharge \the [src.name]"),span("notice","You recharge the enchantment on \the [src.name] using the [G.name]"))
		return TRUE

	. = ..()

/obj/item/weapon/save_item_data(var/mob/living/advanced/player/P,var/save_inventory = TRUE,var/died=FALSE,var/loadout=FALSE)
	RUN_PARENT_SAFE
	if(length(polymorphs)) .["polymorphs"] = polymorphs
	if(upgrade_count >= 1) .["upgrade_count"] = upgrade_count
	if(enchantment)
		.["enchantment"] = list()
		.["enchantment"]["enchantment_type"] = enchantment.type
		.["enchantment"]["strength"] = enchantment.strength
		.["enchantment"]["charge"] = enchantment.charge
		.["enchantment"]["cost"] = enchantment.cost
		.["enchantment"]["max_charge"] = enchantment.max_charge
	if(stored_spellswap)
		SAVEATOM("stored_spellswap")

/obj/item/weapon/load_item_data_pre(var/mob/living/advanced/player/P,var/list/object_data,var/loadout=FALSE)
	RUN_PARENT_SAFE
	if(object_data["polymorphs"]) polymorphs = object_data["polymorphs"]
	if(object_data["upgrade_count"]) upgrade_count = object_data["upgrade_count"]
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

