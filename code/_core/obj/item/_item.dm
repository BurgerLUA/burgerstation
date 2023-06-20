/obj/item/
	name = "item"
	desc = "Oh my god it's an item."

	vis_flags = VIS_INHERIT_PLANE | VIS_INHERIT_DIR | VIS_INHERIT_ID

	var/value_burgerbux

	var/contraband = FALSE //Set to true if this object is considered contraband and can't be saved, but still accessed by the game.
	var/save_on_death = FALSE //Set to true if this item should save on death, regardless of item respawning. This should only be set by special code.
	var/can_save_loadout = TRUE //Set to true if you can save this item in a loadout.

	var/can_rename = FALSE //Can you rename this item?

	var/last_marker //The last person to name this item. Used for moderation purposes.

	plane = PLANE_MOVABLE
	layer = LAYER_OBJ_ITEM

	var/vendor_name = null //Name for the vender. Set to null for it to just use the initial name var.

	size = SIZE_0
	var/weight = 0 //DEPRICATED
	var/quality = -1 //-1 means quality isn't used.
	var/rarity = RARITY_COMMON //Arbitrary Value
	var/tier = -1 //-1 means not set.
	var/tier_type

	damage_type = null

	var/delete_on_drop = FALSE

	var/amount = 1
	var/amount_max = 1
	var/amount_max_icon = 0

	var/pixel_height = 2 //The z size of this, in pixels. Used for sandwiches and burgers.
	var/pixel_height_offset = 0 //The z offset of this, in pixels. Used for sandwiches and burgers.

	var/is_container = FALSE //Setting this to true will open the below inventories on use.
	var/dynamic_inventory_count
	var/obj/hud/inventory/dynamic/dynamic_inventory_type = /obj/hud/inventory/dynamic
	var/container_max_size //This item has a container, how much should it be able to hold in each slot?
	var/container_max_slots //How much each inventory slot can hold.
	var/container_blacklist = list()
	var/container_whitelist = list()
	var/max_inventory_x = MAX_INVENTORY_X
	var/inventory_category = "dynamic"
	var/starting_inventory_y = "BOTTOM:12+1.25"
	var/inventory_y_multiplier = 1
	var/container_priority //Good idea to be negative as non-dynamic inventories (hend, worn, ect) are above 0. Default for dynamic inventories is -101.

	var/loot/loot_to_generate //We generate loot later to prevent lag.
	var/loot_open_verb = "unbuckle"

	var/container_temperature //How much to add or remove from the ambient temperature for calculating reagent temperature. Use for coolers.
	var/container_temperature_mod //The temperature mod of the inventory object. Higher values means faster temperature transition. Lower means slower.

	var/list/obj/hud/inventory/inventories = list() //The inventory holders this object has

	icon_state = "inventory"
	var/icon_state_held_left = "held_left"
	var/icon_state_held_right = "held_right"
	var/icon_state_worn = "worn"
	var/enable_held_icon_states = FALSE
	//var/icon_state_held_single

	collision_flags = FLAG_COLLISION_ITEM

	var/worn_layer = 0

	var/item_slot = SLOT_NONE //Items that can be worn in this slot. Applies to non-held slots only. See _defines/item.dm for info.
	var/item_slot_additional = SLOT_NONE //For stuff like jumpsuits which take both the pant and shirt slot.
	var/item_slot_mod = SLOT_MOD_NONE //The slot mod. See _defines/item.dm for info.
	var/item_slot_layer = SLOT_LAYER_NORMAL //The layer of the clothing. See _defines/item.dm for info.


	mouse_over_pointer = MOUSE_ACTIVE_POINTER

	var/no_held_draw = FALSE

	var/no_initial_blend = FALSE //Should we draw the initial icon when worn/held?

	var/slot_icons = FALSE //Set to true if the clothing is based on where it's slot is.

	var/ignore_other_slots = FALSE

	var/soul_bound = null

	var/list/inventory_bypass = list()

	var/crafting_id = null //Can be a string or a path. Defaults to its path if no value is set.

	var/inventory_sound = 'sound/items/drop/food.ogg' //Sound when moved to an inventory.
	var/drop_sound = 'sound/items/drop/accessory.ogg' //Sound when moved elsewhere

	var/list/inventory_sounds = list(
		'sound/effects/inventory/rustle1.ogg',
		'sound/effects/inventory/rustle2.ogg',
		'sound/effects/inventory/rustle3.ogg',
		'sound/effects/inventory/rustle4.ogg',
		'sound/effects/inventory/rustle5.ogg'
	)

	var/grinder_reagent //The reagent created if this object is grinded in a grinder.
	var/grinder_reagent_amount //The amount to create.

	var/flags_tool = FLAG_TOOL_NONE
	var/tool_time = SECONDS_TO_DECISECONDS(5)

	var/worn_pixel_x = 0
	var/worn_pixel_y = 0

	var/held_pixel_x = 0
	var/held_pixel_y = 0

	var/atom/last_interacted

	var/dyeable = FALSE

	var/mob/living/advanced/inventory_user

	var/unremovable = FALSE //Set to true if it cannot be moved around inventories.

	var/wielded = FALSE
	var/can_wield = FALSE

	anchored = FALSE

	var/block_power = 0.5 //Higher values means it blocks more. Normal weapons should have 1, while stronger items should have between 2-5

	var/list/polymorphs = list()

	var/consume_verb = "drink out of"
	var/transfer_amount = 10

	var/zoom_mul = 1 //Holding this item will grant bonus zoom.

	var/dan_mode = FALSE //Special in hand sprites, used by artist D4n0w4r.
	var/dan_icon_state = "held"
	var/dan_icon_state_wielded = "wielded"
	var/dan_icon_state_back = "back"
	// list(NORTH,EAST,SOUTH,WEST)
	var/dan_offset_pixel_x = list(8,0,-8,0) //Aligned for right hand. These values are inversed in left hand. Automatic offsets are applied for EAST and WEST.
	var/dan_offset_pixel_y = list(0,0,0,0) //Aligned for right hand. These values are inversed in left hand.
	var/dan_layer_above = LAYER_MOB_HELD
	var/dan_layer_below = LAYER_MOB_NONE

	var/obj/item/clothing/additional_clothing_parent

	var/block_sound //The sound made when this item blocks an attack.
	var/list/block_defense = list(
		ATTACK_TYPE_UNARMED = 0.25,
		ATTACK_TYPE_MELEE = 0.5,
		ATTACK_TYPE_RANGED = 0,
		ATTACK_TYPE_MAGIC = 0
	)

	var/can_hold = TRUE
	var/can_wear = FALSE

	density = TRUE

	value = 0

	allow_path = TRUE

	var/uses_until_condition_fall = 0 //Uses until the quality degrades by 1%. 0 to disable. For clothing it's "How much damage equals -1% quality."

	enable_chunk_clean = TRUE
	enable_chunk_handling = TRUE

	var/enable_blood_stains = FALSE //Set to false to disable. Good for laser weapons.
	var/blood_stain_intensity = 0 //Scale, from 0 to 5.
	var/blood_stain_color //Bloodstain color, if any.

	var/enable_damage_overlay = FALSE
	var/enable_torn_overlay = FALSE

	var/no_drop = FALSE //Set to true if you're unable to drop this item via normal means.

	var/combat_range = 1 //Maximum ideal combat range for the weapon.

	var/can_negate_damage = FALSE

	var/unlock_requirement //Accepts a string, which is a prerequiste to unlock this.

/obj/item/proc/can_unlock(var/mob/caller)
	return TRUE

/obj/item/PreDestroy()

	if(inventory_user)
		close_inventory(inventory_user)
		inventory_user = null //Just in case

	if(is_inventory(src.loc))
		drop_item(null,silent=TRUE)

	QDEL_CUT(inventories)

	. = ..()

/obj/item/Destroy()

	additional_clothing_parent = null

	last_interacted = null
	inventory_user = null

	can_save = FALSE
	can_hold = FALSE
	can_wear = FALSE
	unremovable = TRUE

	. = ..()

/obj/item/proc/use_condition(var/amount_to_use=1)

	if(!uses_until_condition_fall)
		return FALSE

	uses_until_condition_fall -= amount_to_use

	if(uses_until_condition_fall <= 0)
		var/highest = initial(uses_until_condition_fall)
		var/quality_to_remove = 1 + FLOOR(-uses_until_condition_fall/highest,1)
		adjust_quality(-quality_to_remove)
		uses_until_condition_fall += highest*quality_to_remove

	return TRUE

/obj/item/Crossed(atom/movable/O,atom/OldLoc)
	return TRUE

/obj/item/Cross(atom/movable/O,atom/oldloc)
	return TRUE

/obj/item/Finalize()

	. = ..()

	if(length(polymorphs) || color != initial(color))
		update_sprite()
	if(!crafting_id)
		crafting_id = src.type

	if(is_turf(loc))
		layer = initial(layer) + clamp(value / 10000,0,0.999)

/obj/item/proc/get_damage_icon_number(var/desired_quality = quality)
	if(quality == -1)
		return 0
	return FLOOR(clamp( (100 - quality) / (100/5),0,5 ),1)

/obj/item/get_base_value()
	. = initial(value) * amount * price_multiplier
	if(quality != -1)
		. *= (0.5 + 0.5*clamp(quality/100,0.25,1.5))

/obj/item/get_inaccuracy(var/atom/source,var/atom/target,var/inaccuracy_modifier=1) //Only applies to melee and unarmed. For ranged, see /obj/item/weapon/ranged/proc/get_bullet_inaccuracy(var/mob/living/L,var/atom/target)
	if(inaccuracy_modifier <= 0)
		return 0
	if(is_living(source))
		var/mob/living/L = source
		if(L.qdeleting)
			return 100
		return (1 - L.get_skill_power(SKILL_PRECISION,0,0.5,1))*inaccuracy_modifier*4
	return 0

/obj/item/proc/add_item_count(var/amount_to_add,var/bypass_checks = FALSE)

	if(!bypass_checks)
		if(!amount_to_add)
			return 0
		else if(amount_to_add > 0)
			amount_to_add = min(amount_to_add,amount_max - amount)
		else if(amount_to_add < 0)
			amount_to_add = max(amount_to_add,-amount)

	amount += amount_to_add

	if(amount <= 0)
		qdel(src)
	else
		update_sprite()
		update_value()

	return amount_to_add

/obj/item/can_be_attacked(var/atom/attacker,var/atom/weapon,var/params,var/damagetype/damage_type)
	return FALSE

/obj/item/can_be_grabbed(var/atom/grabber,var/messages=TRUE)

	if(!src.z)
		if(messages && is_living(grabber))
			var/mob/living/L = grabber
			L.to_chat(span("warning","\The [src.name] needs to be out in the open before you can grab it!"))
		return FALSE

	return ..()

/obj/item/proc/can_add_object_to_src_inventory(var/mob/caller,var/obj/item/object,var/enable_messages = TRUE,var/bypass = FALSE) //Can we add object to src?

	if(!length(inventories))
		return null

	if(object.amount_max > 1) //We can transfer stacks.
		//First pass.
		for(var/k in inventories)
			var/obj/hud/inventory/I = k
			var/obj/item/ITM = I.get_top_object()
			if(ITM && object.can_transfer_stacks_to(ITM))
				return ITM

	for(var/k in inventories)
		var/obj/hud/inventory/I = k
		if(I.can_slot_object(object,enable_messages,bypass))
			return I

	return null

/obj/item/proc/add_object_to_src_inventory(var/mob/caller,var/obj/item/object,var/enable_messages = TRUE,var/bypass = FALSE,var/silent=FALSE) //We add the object to this item's inventory.

	if(!length(inventories))
		return FALSE

	if(object == src)
		return FALSE

	var/did_add = FALSE
	while(!object.qdeleting)
		var/obj/result = src.can_add_object_to_src_inventory(caller,object,FALSE,bypass)
		if(!result)
			break
		if(is_inventory(result))
			var/obj/hud/inventory/found_inventory = result
			found_inventory.add_object(object,enable_messages,bypass,silent=silent)
			if(caller && enable_messages)
				caller.to_chat(span("notice","You stuff \the [object.name] in \the [src.name]."))
			return TRUE //No need to loop.
		if(is_item(result))
			var/obj/item/I = result
			if(object.transfer_amount_to(I))
				did_add = TRUE

	if(did_add)
		if(object.qdeleting) //Means that the stacks were likely transfered to another object.
			if(caller && enable_messages)
				caller.to_chat(span("notice","You stuff \the [object.name] in \the [src.name]."))
			return TRUE
		if(caller && enable_messages)
			caller.to_chat(span("notice","You stuff some of \the [object.name] in \the [src.name]."))
		return TRUE

	if(caller && enable_messages)
		caller.to_chat(span("warning","You don't have enough inventory space inside \the [src.name] to hold \the [object.name]!"))

	return FALSE

/obj/item/New(var/desired_loc)

	if(is_container && size <= container_max_size && !length(container_whitelist))
		log_error("Warning: [get_debug_name()] had a size ([size]) less than its container max size ([container_max_size]).")
		size = container_max_size + 1

	if(!damage_type)
		switch(weight)
			if(-INFINITY to 5)
				damage_type = /damagetype/item/trivial
			if(5 to 10)
				damage_type = /damagetype/item/light
			if(10 to 20)
				damage_type = /damagetype/item/medium
			if(20 to 40)
				damage_type = /damagetype/item/heavy
			if(40 to INFINITY)
				damage_type = /damagetype/item/super

	for(var/i=1, i <= length(inventories), i++)
		var/obj/hud/inventory/new_inv = inventories[i]
		inventories[i] = new new_inv(src)
		//Doesn't need to be initialized as it's done later.
		if(isnum(container_max_slots))
			inventories[i].max_slots = container_max_slots
		if(isnum(container_max_size))
			inventories[i].max_size = container_max_size
		if(container_blacklist && length(container_blacklist))
			inventories[i].item_blacklist = container_blacklist
		if(container_whitelist && length(container_whitelist))
			inventories[i].item_whitelist = container_whitelist
		if(isnum(container_temperature))
			inventories[i].inventory_temperature = container_temperature
		if(isnum(container_temperature_mod))
			inventories[i].inventory_temperature_mod = container_temperature_mod

	for(var/i=1, i <= dynamic_inventory_count, i++)
		var/obj/hud/inventory/dynamic/D = new dynamic_inventory_type(src)
		//Doesn't need to be initialized as it's done later.
		D.id = "\ref[src]_dynamic_[i]"
		D.slot_num = i
		D.inventory_category = inventory_category
		if(isnum(container_max_slots))
			D.max_slots = container_max_slots
		if(isnum(container_max_size))
			D.max_size = container_max_size
		if(container_blacklist && length(container_blacklist))
			D.item_blacklist = container_blacklist
		if(container_whitelist && length(container_whitelist))
			D.item_whitelist = container_whitelist
		if(isnum(container_temperature))
			D.inventory_temperature = container_temperature
		if(isnum(container_temperature_mod))
			D.inventory_temperature_mod = container_temperature_mod
		if(isnum(container_priority))
			D.priority = container_priority
		inventories += D

	. = ..()

/obj/item/proc/update_owner(desired_owner)
	for(var/v in inventories)
		var/obj/hud/inventory/I = v
		I.update_owner(desired_owner)

/obj/item/proc/get_owner()
	if(is_inventory(src.loc))
		var/obj/hud/inventory/I = src.loc
		return I.owner

	return null

/obj/item/update_sprite()

	. = ..()

	if(is_inventory(src.loc))
		var/obj/hud/inventory/I = src.loc
		I.overlays.Cut()
		I.update_overlays()


/obj/item/get_examine_list(var/mob/examiner)

	. = list()
	. += div("examine_title","[ICON_TO_HTML(src.icon,src.icon_state,32,32)][src.name]")
	. += div("rarity [rarity]",capitalize(rarity))

	if(tier >= 1)
		. += div("rarity center","Tier \Roman[tier][tier_type ? " [tier_type]" : ""].")
	else if(tier == 0)
		. += div("rarity center","Tier [tier][tier_type ? " [tier_type]" : ""].")

	if(contraband)
		. += div("bad bold center","CONTRABAND")

	if(quality != -1)
		if(quality <= 0)
			. += div("rarity bad","<b>Quality</b>: BROKEN")
		else if(quality >= 200)
			. += div("rarity legendary","<b>Quality</b>: [FLOOR(quality,1)]%")
		else if(quality > 100)
			. += div("rarity good","<b>Quality</b>: [FLOOR(quality,1)]%")
		else if(quality <= 60)
			. += div("rarity bad","<b>Quality</b>: [FLOOR(quality,1)]%")
		else
			. += div("rarity common","<b>Quality</b>: [FLOOR(quality,1)]%")

	if(luck < 50)
		. += div("rarity bad","<b>Luck</b>: -[50 - luck]")
	else if(luck > 50)
		. += div("rarity good","<b>Luck</b>: +[luck-50]")

	. += div("rarity","Base Value: [get_display_value()]cr.")
	. += div("weightsize","Size: [size], Weight: [weight]")

	if(amount > 1) . += div("weightsize","Quantity: [amount].")
	. += div("examine_description","\"[src.desc]\"")
	. += div("examine_description_long",src.desc_extended)

/obj/item/proc/get_display_value()
	return get_base_value()

/obj/item/get_examine_details_list(var/mob/examiner)
	. = ..()
	if(reagents && reagents.volume_current)
		. += div("notice",reagents.get_contents_english())

/obj/item/proc/update_lighting_for_owner()

	var/atom/desired_atom = src

	if(is_inventory(src.loc))
		var/obj/hud/inventory/I = src.loc
		var/mob/living/advanced/A = I.owner
		if(is_advanced(A))
			desired_atom = A

	light?.set_top_atom(desired_atom)
	light_sprite?.set_top_atom(desired_atom)
	light_sprite?.update_sprite()

	return TRUE


/obj/item/post_move(var/atom/old_loc)

	if(is_container && inventory_user)
		if(is_inventory(old_loc) && is_inventory(loc))
			var/obj/hud/inventory/I1 = old_loc
			var/obj/hud/inventory/I2 = loc
			if(I1.owner != I2.owner)
				close_inventory(null)
		else if(!can_interact_with_inventory(inventory_user))
			close_inventory(null)

	update_lighting_for_owner()

	. = ..()

/obj/item/proc/on_equip(var/atom/old_location,var/silent=FALSE)

	var/obj/hud/inventory/new_location = loc

	if(old_location && new_location)
		var/turf/old_turf = get_turf(old_location)
		var/turf/new_turf = get_turf(new_location)
		if(old_turf != new_turf)
			new/obj/effect/temp/item_pickup(new_turf,2,old_turf,src,"pickup")

	if(new_location)
		update_lighting_for_owner()
		last_interacted = new_location.owner

	return TRUE

/obj/item/proc/pre_equip(var/atom/old_location,var/obj/hud/inventory/new_location) //When the item is picked up or worn.
	return TRUE

/obj/item/proc/on_unequip(var/obj/hud/inventory/old_inventory,var/silent=FALSE) //When the object is dropped from the old_inventory

	if(!is_inventory(src.loc) && delete_on_drop)
		qdel(src)
	else
		if(additional_clothing_parent)
			drop_item(additional_clothing_parent) //This retracts the clothing.

		if(old_inventory && loc)
			var/turf/old_turf = get_turf(old_inventory)
			var/turf/new_turf = get_turf(loc)
			if(old_turf != new_turf)
				new/obj/effect/temp/item_pickup(new_turf,2,old_turf,src,src.z ? "drop" : "transfer")

	return TRUE

/obj/item/set_light(l_range, l_power, l_color = NONSENSICAL_VALUE, angle = NONSENSICAL_VALUE, no_update = FALSE,debug = FALSE)
	. = ..()
	update_lighting_for_owner()

/obj/item/set_light_sprite(l_range, l_power, l_color = NONSENSICAL_VALUE, angle = NONSENSICAL_VALUE, no_update = FALSE,debug = FALSE)
	. = ..()
	update_lighting_for_owner()


/obj/item/proc/inventory_to_list()

	. = list()

	for(var/k in inventories)
		var/obj/hud/inventory/I = k
		var/obj/item/I2 = I.get_top_object()
		if(I2) . += I2

/obj/item/proc/can_be_held(var/mob/living/advanced/owner,var/obj/hud/inventory/I)
	if(delete_on_drop)
		return FALSE
	if(anchored)
		return FALSE
	if(unremovable)
		return FALSE
	if(additional_clothing_parent && is_inventory(src.loc))
		return FALSE
	if(!can_hold)
		return FALSE
	return TRUE

/obj/item/proc/can_be_worn(var/mob/living/advanced/owner,var/obj/hud/inventory/I,var/messages=FALSE)
	if(delete_on_drop)
		if(messages) owner.to_chat("\The [src.name] cannot be removed this way!")
		return FALSE
	if(anchored)
		if(messages) owner.to_chat("\The [src.name] cannot be removed this way!")
		return FALSE
	if(unremovable)
		if(messages) owner.to_chat("\The [src.name] cannot be removed this way!")
		return FALSE
	if(additional_clothing_parent && is_inventory(src.loc))
		if(messages) owner.to_chat("\The [src.name] cannot be removed this way!")
		return FALSE
	if(!can_wear)
		if(messages) owner.to_chat("\The [src.name] cannot be worn!")
		return FALSE
	return TRUE

/obj/item/proc/update_held_icon()

	if(is_inventory(src.loc))
		var/obj/hud/inventory/I = src.loc
		I.update_held_icon(src)

	return TRUE

/obj/item/trigger(var/mob/caller,var/atom/source,var/signal_freq,var/signal_code)
	last_interacted = caller
	. = ..()

/obj/item/proc/get_reagents_to_consume(var/mob/living/consumer)
	var/reagent_container/temp/T = new(src,1000)
	reagents.transfer_reagents_to(T,get_consume_size(consumer))
	return T.qdeleting ? null : T

/obj/item/proc/get_consume_size(var/mob/living/L)
	. = 5
	if(is_advanced(L))
		var/mob/living/advanced/A = L
		if(A.species)
			var/species/S = SSspecies.all_species[A.species]
			. = S.bite_size

/obj/item/proc/feed(var/mob/caller,var/mob/living/target)
	var/reagent_container/R = get_reagents_to_consume(target)
	if(!R)
		return FALSE
	R.consume(caller,target)
	return TRUE

/obj/item/proc/try_transfer_reagents(var/mob/caller,var/atom/object,var/location,var/control,var/params)

	INTERACT_CHECK
	INTERACT_CHECK_OBJECT

	var/self_feed = caller == object

	if(is_living(caller) && allow_reagent_transfer_from)
		var/mob/living/L = caller
		if(L.attack_flags & CONTROL_MOD_DISARM) //SPLASH
			reagents.splash(caller,object,reagents.volume_current,FALSE,0.75)
			return TRUE

	if(can_feed(caller,object))
		PROGRESS_BAR(caller,src,self_feed ? BASE_FEED_TIME_SELF : BASE_FEED_TIME,src::feed(),caller,object)
		PROGRESS_BAR_CONDITIONS(caller,src,src::can_feed(),caller,object)
		return TRUE

	if(object.reagents)
		//Find out the behavior.
		//TODO: Add liquid transfer sounds.
		if(object.allow_reagent_transfer_to && allow_reagent_transfer_from)
			if(reagents.volume_current <= 0)
				caller.to_chat(span("warning","\The [src.name] is empty!"))
				return FALSE
			if(object.reagents.volume_current >= object.reagents.volume_max)
				caller.to_chat(span("warning","\The [object.name] is full!"))
				return FALSE
			var/actual_transfer_amount = reagents.transfer_reagents_to(object.reagents,transfer_amount, caller = caller)
			caller.to_chat(span("notice","You transfer [actual_transfer_amount] units of liquid to \the [object]."))
			play_sound('sound/items/consumables/pourwater.ogg',get_turf(caller),range_max=VIEW_RANGE*0.5)
			return TRUE
		else if(object.allow_reagent_transfer_from && allow_reagent_transfer_to)
			if(object.reagents.volume_current <= 0)
				caller.to_chat(span("warning","\The [object.name] is empty!"))
				return FALSE
			if(reagents.volume_current >= reagents.volume_max)
				caller.to_chat(span("warning","\The [src.name] is full!"))
				return FALSE
			var/actual_transfer_amount = object.reagents.transfer_reagents_to(reagents,transfer_amount, caller = caller)
			caller.to_chat(span("notice","You transfer [actual_transfer_amount] units of liquid to \the [src]."))
			play_sound('sound/items/consumables/pourwater.ogg',get_turf(caller),range_max=VIEW_RANGE*0.5)
			return TRUE

	return FALSE

/obj/item/proc/can_feed(var/mob/caller,var/atom/target)

	INTERACT_CHECK_NO_DELAY(src)
	INTERACT_CHECK_NO_DELAY(target)

	if(!reagents)
		return FALSE

	if(!is_living(target))
		return FALSE

	var/mob/living/L = target

	if(L.dead)
		caller.to_chat(span("warning","\The [L.name] is dead!"))
		return FALSE

	if(!reagents.volume_current)
		caller.to_chat(span("notice","\The [src.name] is empty!"))
		return FALSE

	if(is_living(caller))
		var/mob/living/C = caller
		if(C.attack_flags & CONTROL_MOD_DISARM) //Splash
			return FALSE
		if(reagents.contains_lethal && L != C && !allow_hostile_action(C.loyalty_tag,L))
			C.to_chat(span("warning","Your loyalties prevent you from feeding dangerous reagents to your allies!"))
			return FALSE

	return TRUE

/obj/item/act_explode(var/atom/owner,var/atom/source,var/atom/epicenter,var/magnitude,var/desired_loyalty_tag)

	. = ..()

	if(magnitude > 3)

		var/x_mod = src.x - epicenter.x
		var/y_mod = src.y - epicenter.y

		var/max = max(abs(x_mod),abs(y_mod))

		if(!max)
			x_mod = pick(-1,1)
			y_mod = pick(-1,1)
		else
			x_mod *= 1/max
			y_mod *= 1/max

		throw_self(owner,null,null,null,max(TILE_SIZE-1,x_mod*magnitude*2),max(TILE_SIZE-1,y_mod*magnitude*2))

/obj/item/proc/get_overlay_ids()
	return list("\ref[src]")

/obj/item/proc/can_block()
	return TRUE

/obj/item/proc/can_parry()
	return TRUE

/obj/item/can_attack(var/atom/attacker,var/atom/victim,var/atom/weapon,var/params,var/damagetype/damage_type)
	if(quality != -1 && quality <= 0)
		if(ismob(attacker))
			var/mob/M = attacker
			M.to_chat(span("danger","\The [src.name] is broken!"))
		return FALSE
	return ..()

/obj/item/attack(var/atom/attacker,var/atom/victim,var/list/params=list(),var/atom/blamed,var/ignore_distance = FALSE, var/precise = FALSE,var/damage_multiplier=1,var/damagetype/damage_type_override)  //The src attacks the victim, with the blamed taking responsibility
	damage_multiplier *= get_quality_bonus(0.25,2)
	. = ..()

/obj/item/proc/set_bloodstain(var/desired_level,var/desired_color,var/force=FALSE)

	if(!force && !enable_blood_stains)
		return FALSE

	if(!blood_stain_color && !desired_color)
		return FALSE

	desired_level = clamp(desired_level,0,5)

	//Store the old values.
	var/old_level = blood_stain_intensity
	var/old_color = blood_stain_color

	//Set the new values.
	blood_stain_intensity = desired_level
	if(desired_color)
		blood_stain_color = desired_color

	//If the old values are the same as the new levels, don't even bother doing a visual update.
	if(!force && CEILING(old_level,1) == CEILING(blood_stain_intensity,1) && old_color == desired_color)
		return FALSE

	update_sprite()
	add_blend(
		"bloodstain",
		desired_icon_state = blood_stain_intensity ? "[CEILING(blood_stain_intensity,1)]" : null,
		desired_color = blood_stain_color
	)
	if(is_inventory(loc))
		var/obj/hud/inventory/I = loc
		if(is_advanced(I.owner))
			src.handle_overlays(I.owner,worn=I.worn,update=TRUE)

	return TRUE

/obj/item/organ/set_bloodstain(var/desired_level,var/desired_color,var/force=FALSE)
	. = ..()
	if(. && is_advanced(loc))
		src.handle_overlays(loc,worn=TRUE,update=TRUE)

/obj/item/update_icon()
	. = ..()
	if(length(polymorphs))
		icon = null

/obj/item/update_overlays()

	. = ..()

	if(length(polymorphs))
		var/initial_icon = initial(icon)
		var/initial_icon_state = initial(icon_state)

		for(var/polymorph_name in polymorphs)
			var/polymorph_color = polymorphs[polymorph_name]
			var/image/I = new/image(initial_icon,"[initial_icon_state]_[polymorph_name]")
			I.color = polymorph_color
			add_overlay(I)

	if(enable_blood_stains && blood_stain_intensity > 0 && blood_stain_color)
		var/image/I = new/image('icons/mob/living/advanced/overlays/blood_overlay.dmi',"[CEILING(blood_stain_intensity,1)]")
		I.appearance_flags = src.appearance_flags | RESET_COLOR
		I.blend_mode = BLEND_INSET_OVERLAY
		I.color = blood_stain_color
		add_overlay(I)


/obj/item/proc/get_quality_bonus(var/minimum=0.5,var/maximum=2,var/threshold=60)
	var/quality_mod_to_use = 1
	if(quality != -1)
		if(quality < 100)
			quality_mod_to_use = min(1,quality/threshold) //Start failing only below the threshold.
		else
			quality_mod_to_use = quality/100
		quality_mod_to_use = FLOOR(quality_mod_to_use,0.01)
	return min(minimum + quality_mod_to_use*(1-minimum),maximum)

/obj/item/proc/adjust_quality(var/quality_to_add=0)

	if(quality == -1)
		return FALSE

	if(quality >= 200) //Cannot add or remove quality.
		return TRUE

	var/original_quality = quality
	var/original_damage_num = get_damage_icon_number()

	quality = FLOOR(quality + quality_to_add,0.01)

	if(original_quality > 0 && quality <= 0)
		visible_message(span("danger","\The [src.name] breaks!"))

	if(enable_torn_overlay || enable_damage_overlay)
		var/desired_damage_num = get_damage_icon_number()
		if(original_damage_num != desired_damage_num)
			update_sprite()
			add_blend("damage_overlay_noise", desired_icon_state = desired_damage_num ? "[desired_damage_num]" : null)
			add_blend("damage_overlay", desired_icon_state = desired_damage_num ? "[desired_damage_num]" : null)

	update_value()

	return TRUE

/obj/item/dust(var/atom/source)
	qdel(src)
	return TRUE


/obj/item/proc/negate_damage(var/atom/attacker,var/atom/victim,var/atom/weapon,var/atom/hit_object,var/atom/blamed,var/damage_dealt=0)
	return FALSE

/obj/item/Generate()
	fill_inventory()
	if(length(inventories))
		for(var/obj/item/I in src.contents)
			if(I.finalized)
				continue
			pre_fill_inventory(I)
			I.initialize_type = src.initialize_type
			INITIALIZE(I)
			GENERATE(I)
			FINALIZE(I)
			post_fill_inventory(I)
			add_object_to_src_inventory(null,I,enable_messages=FALSE,bypass=TRUE,silent=TRUE)
	. = ..()

