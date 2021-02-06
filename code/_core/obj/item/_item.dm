/obj/item/
	name = "item"
	desc = "Oh my god it's an item."

	vis_flags = VIS_INHERIT_ID | VIS_INHERIT_PLANE | VIS_INHERIT_LAYER

	var/value_burgerbux

	var/last_marker //The last person to name this item. Used for moderation purposes.

	layer = LAYER_OBJ_ITEM

	var/vendor_name = null //Name for the vender. Set to null for it to just use the initial name var.

	var/rarity = RARITY_COMMON

	var/size = 1
	var/weight = 0 //DEPRICATED
	var/quality = 100

	var/list/material = list() //Stored materials

	damage_type = null

	var/delete_on_drop = FALSE

	var/item_count_current = 1
	var/item_count_max = 1
	var/item_count_max_icon = 0

	var/pixel_height = 2 //The z size of this, in pixels. Used for sandwiches and burgers.
	var/pixel_height_offset = 0 //The z offset of this, in pixels. Used for sandwiches and burgers.

	var/is_container = FALSE //Setting this to true will open the below inventories on use.
	var/dynamic_inventory_count = 0
	var/obj/hud/inventory/dynamic/dynamic_inventory_type = /obj/hud/inventory/dynamic
	var/container_max_size = 0 //This item has a container, how much should it be able to hold in each slot?
	var/container_max_slots = 0 //How much each inventory slot can hold.
	var/container_blacklist = list()
	var/container_whitelist = list()

	var/container_temperature = 0 //How much to add or remove from the ambient temperature for calculating reagent temperature. Use for coolers.
	var/container_temperature_mod = 1 //The temperature mod of the inventory object. Higher values means faster temperature transition. Lower means slower.

	var/list/obj/hud/inventory/inventories = list() //The inventory holders this object has

	icon_state = "inventory"
	var/icon_state_held_left = "held_left"
	var/icon_state_held_right = "held_right"
	var/icon_state_worn = "worn"
	var/enable_held_icon_states = FALSE
	//var/icon_state_held_single

	collision_flags = FLAG_COLLISION_ITEM

	var/worn_layer = 0

	var/item_slot = SLOT_NONE

	mouse_over_pointer = MOUSE_ACTIVE_POINTER

	var/no_held_draw = FALSE

	var/no_initial_blend = FALSE //Should we draw the initial icon when worn/held?

	var/slot_icons = FALSE //Set to true if the clothing is based on where it's slot is.

	var/ignore_other_slots = FALSE

	var/soul_bound = null

	var/list/inventory_bypass = list()

	var/crafting_id = null

	var/inventory_sound = 'sound/items/drop/food.ogg' //Sound when moved to an inventory.
	var/drop_sound = 'sound/items/drop/accessory.ogg' //Sound when moved elsewhere

	var/list/inventory_sounds = list(
		'sound/effects/inventory/rustle1.ogg',
		'sound/effects/inventory/rustle2.ogg',
		'sound/effects/inventory/rustle3.ogg',
		'sound/effects/inventory/rustle4.ogg',
		'sound/effects/inventory/rustle5.ogg'
	)

	var/list/alchemy_reagents = list() //Reagents that are created if this is processed in an alchemy table. Format: reagent_type = volume.

	var/flags_tool = FLAG_TOOL_NONE
	var/tool_time = SECONDS_TO_DECISECONDS(5)

	var/worn_pixel_x = 0
	var/worn_pixel_y = 0

	var/atom/last_interacted

	var/dyeable = FALSE

	var/mob/living/advanced/inventory_user

	var/unremovable = FALSE //Set to true if it cannot be moved around inventories.

	var/wielded = FALSE
	var/can_wield = FALSE

	ignore_incoming_collisons = TRUE

	anchored = FALSE

	var/block_power = 0.5 //Higher values means it blocks more. Normal weapons should have 1, while stronger items should have between 2-5

	//This applies to things like beakers and whatnot. This affects player-controlled transfers, and does not affect procs like add_reagent
	var/allow_reagent_transfer_to = FALSE
	var/allow_reagent_transfer_from = FALSE

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

	var/list/block_defense_rating = DEFAULT_BLOCK
	var/block_defense_value = 0 //Automatically calculated.

	var/can_hold = TRUE
	var/can_wear = FALSE

	density = 1

	value = -1

/obj/item/proc/get_quality_bonus(var/minimum=0.5,var/maximum=2)
	return min(minimum + FLOOR(quality/100,0.01)*(1-minimum),maximum)

/obj/item/proc/adjust_quality(var/quality_to_add=0)

	quality = FLOOR(quality + quality_to_add,0.01)

	if(quality <= 0)
		visible_message(span("danger","\The [src.name] breaks!"))

	return TRUE

/obj/item/Crossed(atom/movable/O)
	return TRUE

/obj/item/Cross(atom/movable/O)
	return TRUE

/obj/item/Finalize()
	. = ..()
	if(length(polymorphs))
		update_sprite()

	for(var/k in block_defense_rating)
		var/v = block_defense_rating[k]
		block_defense_value += v

	return .

/obj/item/get_base_value()
	return value * item_count_current * price_multiplier

/obj/item/proc/transfer_item_count_to(var/obj/item/target,var/amount_to_transfer = item_count_current)
	if(!amount_to_transfer) return 0
	if(amount_to_transfer < 0)
		return target.transfer_item_count_to(src,-amount_to_transfer)
	amount_to_transfer = min(
		amount_to_transfer, //What we want to transfer
		item_count_current, //What we can actually transfer from
		target.item_count_max - target.item_count_current //What the target can actually hold.
	)
	return target.add_item_count(-src.add_item_count(-amount_to_transfer,TRUE),TRUE)

/obj/item/get_inaccuracy(var/atom/source,var/atom/target,var/inaccuracy_modifier) //Only applies to melee. For ranged, see projectile.
	if(is_living(source))
		var/mob/living/L = source
		return (1 - L.get_skill_power(SKILL_PRECISION))*inaccuracy_modifier*8
	return 0

/obj/item/proc/add_item_count(var/amount_to_add,var/bypass_checks = FALSE)

	if(!bypass_checks)
		if(!amount_to_add)
			return 0
		else if(amount_to_add > 0)
			amount_to_add = min(amount_to_add,item_count_max - item_count_current)
		else if(amount_to_add < 0)
			amount_to_add = max(amount_to_add,-item_count_current)

	item_count_current += amount_to_add

	if(item_count_current <= 0)
		qdel(src)
	else
		update_sprite()

	return amount_to_add

/*
/obj/item/can_block(var/atom/attacker,var/atom/attacking_weapon,var/atom/victim,var/damagetype/DT)

	if(is_living(victim))
		var/mob/living/V = victim
		return (V.get_skill_power(SKILL_BLOCK)) >= block_difficulty[DT.get_attack_type()] ? src : null

	return src

/obj/item/can_parry(var/atom/attacker,var/atom/attacking_weapon,var/atom/victim,var/damagetype/DT)

	if(is_living(victim))
		var/mob/living/V = victim
		return (V.get_skill_power(SKILL_PARRY)) >= block_difficulty[DT.get_attack_type()] ? src : null

	return src
*/


/obj/item/Destroy()

	additional_clothing_parent = null

	for(var/k in inventories)
		var/obj/hud/inventory/I = k
		qdel(I)

	inventories.Cut()

	last_interacted = null

	if(loc)
		drop_item(silent=TRUE)

	return ..()

/atom/proc/quick(var/mob/living/advanced/caller,var/atom/object,location,control,params)
	return FALSE

/obj/item/can_be_attacked(var/atom/attacker,var/atom/weapon,var/params,var/damagetype/damage_type)
	return FALSE

/obj/item/can_be_grabbed(var/atom/grabber,var/messages=TRUE)

	if(!isturf(src.loc))
		if(messages && is_living(grabber))
			var/mob/living/L = grabber
			L.to_chat(span("warning","\The [src.name] needs to be out in the open before you can grab it!"))
		return FALSE

	return ..()

/obj/item/proc/can_add_to_inventory(var/mob/caller,var/obj/item/object,var/enable_messages = TRUE,var/bypass = FALSE)

	if(!length(inventories))
		return null

	for(var/k in inventories)
		var/obj/hud/inventory/I = k
		if(bypass && length(I.contents) >= I.max_slots)
			continue
		if(I.can_slot_object(object,enable_messages))
			return I

	return null

/obj/item/proc/add_to_inventory(var/mob/caller,var/obj/item/object,var/enable_messages = TRUE,var/bypass = FALSE,var/silent=FALSE) //We add the object to this item's inventory.

	if(!length(inventories))
		return FALSE

	var/added = FALSE

	if(object != src)
		var/obj/hud/inventory/found_inventory = can_add_to_inventory(caller,object,FALSE,bypass)
		if(found_inventory)
			found_inventory.add_object(object,enable_messages,bypass,silent=silent)
			added = TRUE

	if(enable_messages && caller)
		if(added)
			caller.to_chat(span("notice","You stuff \the [object.name] in \the [src.name]."))
		else
			caller.to_chat(span("warning","You don't have enough inventory space inside \the [src.name] to hold \the [object.name]!"))

	return added

/obj/item/New(var/desired_loc)

	if(is_container && size <= container_max_size)
		log_error("Warning: [get_debug_name()] had a size ([size]) less than its container max size ([container_max_size]).")
		size = container_max_size + 1

	if(!damage_type)
		switch(size)
			if(0 to SIZE_3)
				damage_type = /damagetype/item/light
			if(SIZE_3 to SIZE_5)
				damage_type = /damagetype/item/medium
			if(SIZE_5 to INFINITY)
				damage_type = /damagetype/item/heavy

	for(var/i=1, i <= length(inventories), i++)
		var/obj/hud/inventory/new_inv = inventories[i]
		inventories[i] = new new_inv(src)
		//Doesn't need to be initialized as it's done later.
		if(container_max_slots)
			inventories[i].max_slots = container_max_slots
		if(container_max_size)
			inventories[i].max_size = container_max_size
		if(container_blacklist && length(container_blacklist))
			inventories[i].item_blacklist = container_blacklist
		if(container_whitelist && length(container_whitelist))
			inventories[i].item_whitelist = container_whitelist
		if(container_temperature)
			inventories[i].inventory_temperature_mod = container_temperature
		if(container_temperature_mod)
			inventories[i].inventory_temperature_mod_mod = container_temperature_mod

	for(var/i=1, i <= dynamic_inventory_count, i++)
		var/obj/hud/inventory/dynamic/D = new dynamic_inventory_type(src)
		//Doesn't need to be initialized as it's done later.
		D.id = "dynamic_[i]"
		D.slot_num = i
		if(container_max_slots)
			D.max_slots = container_max_slots
		if(container_max_size)
			D.max_size = container_max_size
		if(container_blacklist && length(container_blacklist))
			D.item_blacklist = container_blacklist
		if(container_whitelist && length(container_whitelist))
			D.item_whitelist = container_whitelist
		if(container_temperature)
			D.inventory_temperature_mod = container_temperature
		if(container_temperature_mod)
			D.inventory_temperature_mod_mod = container_temperature_mod
		inventories += D

	return ..()

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

	return .

/obj/item/get_examine_list(var/mob/examiner)

	. = list()
	. += div("examine_title","[ICON_TO_HTML(src.icon,src.icon_state,32,32)][src.name]")
	. += div("rarity [rarity]",capitalize(rarity))

	if(quality <= 0)
		. += div("rarity bad","<b>Quality</b>: BROKEN")
	else if(quality < 100)
		. += div("rarity bad","<b>Quality</b>: -[100 - FLOOR(quality,1)]%")
	else if(quality > 100)
		. += div("rarity good","<b>Quality</b>: +[FLOOR(quality,1) - 100]%")

	if(luck < 50)
		. += div("rarity bad","<b>Luck</b>: -[50 - luck]")
	else if(luck > 50)
		. += div("rarity good","<b>Luck</b>: +[luck-50]")

	. += div("rarity","Value: [CEILING(value,1)]cr.")
	. += div("weightsize","Size: [size], Weight: [weight]")

	if(item_count_current > 1) . += div("weightsize","Quantity: [item_count_current].")
	. += div("examine_description","\"[src.desc]\"")
	. += div("examine_description_long",src.desc_extended)

	return .

/obj/item/proc/update_lighting_for_owner(var/obj/hud/inventory/inventory_override)

	var/obj/hud/inventory/I = inventory_override || src.loc

	if(!I || !is_inventory(I))
		return FALSE

	if(!I.owner || !is_advanced(I.owner))
		return FALSE

	var/mob/living/advanced/A = I.owner
	A.update_single_lighting(src)

	return TRUE

/obj/item/post_move(var/atom/old_loc)

	if(isturf(loc))
		if(delete_on_drop)
			qdel(src)
			return TRUE
		else
			queue_delete(src,ITEM_DELETION_TIME_DROPPED,TRUE)
	else
		undelete(src)

	return ..()

/obj/item/proc/on_pickup(var/atom/old_location,var/obj/hud/inventory/new_location) //When the item is picked up or worn.

	if(is_container)
		for(var/k in inventories)
			var/obj/hud/inventory/I = k
			I.update_owner(new_location.owner)

	if(old_location && new_location)
		var/turf/OL = get_turf(old_location)
		var/turf/NL = get_turf(new_location)
		if(OL != NL)
			new/obj/effect/temp/item_pickup(NL,2,OL,src,"pickup")

	if(new_location)
		update_lighting_for_owner(new_location)
		last_interacted = new_location.owner
		pixel_x = initial(pixel_x)
		pixel_y = initial(pixel_y)

	return TRUE

/obj/item/proc/pre_pickup(var/atom/old_location,var/obj/hud/inventory/new_location) //When the item is picked up or worn.
	return TRUE

/obj/item/set_light(l_range, l_power, l_color = NONSENSICAL_VALUE, angle = NONSENSICAL_VALUE, no_update = FALSE,debug = FALSE)
	. = ..()
	update_lighting_for_owner()
	return .

/obj/item/set_light_sprite(l_range, l_power, l_color = NONSENSICAL_VALUE, angle = NONSENSICAL_VALUE, no_update = FALSE,debug = FALSE)
	. = ..()
	update_lighting_for_owner()
	return .

/obj/item/proc/on_drop(var/obj/hud/inventory/old_inventory,var/atom/new_loc,var/silent=FALSE)

	if(additional_clothing_parent)
		drop_item(additional_clothing_parent) //This retracts the clothing.

	if(light)
		light.update(src)

	if(old_inventory && new_loc)
		var/turf/OL = get_turf(old_inventory)
		var/turf/NL = get_turf(new_loc)
		if(OL != NL)
			new/obj/effect/temp/item_pickup(NL,2,OL,src,isturf(new_loc) ? "drop" : "transfer")

	update_lighting_for_owner(old_inventory)

	return TRUE

/obj/item/proc/inventory_to_list()

	. = list()

	for(var/k in inventories)
		var/obj/hud/inventory/I = k
		var/obj/item/I2 = I.get_top_object()
		if(I2) . += I2

	return .


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

/obj/item/update_icon()

	if(length(polymorphs))
		icon = initial(icon)
		var/icon/I = ICON_INVISIBLE
		for(var/polymorph_name in polymorphs)
			var/polymorph_color = polymorphs[polymorph_name]
			var/icon/I2 = new /icon(icon,"[icon_state]_[polymorph_name]")
			I2.Blend(polymorph_color,ICON_MULTIPLY)
			I.Blend(I2,ICON_OVERLAY)
		icon = I

	return ..()

/obj/item/proc/update_held_icon()

	if(is_inventory(src.loc))
		var/obj/hud/inventory/I = src.loc
		I.update_held_icon(src)

	return TRUE

/obj/item/trigger(var/mob/caller,var/atom/source,var/signal_freq,var/signal_code)
	last_interacted = caller
	return ..()

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
	return .

/obj/item/proc/feed(var/mob/caller,var/mob/living/target)
	var/reagent_container/R = get_reagents_to_consume(target)
	if(!R)
		return FALSE
	R.consume(caller,target)
	return TRUE

/obj/item/proc/try_transfer_reagents(var/mob/caller,var/atom/object,var/location,var/control,var/params)



	var/self_feed = caller == object

	if(is_living(caller) && allow_reagent_transfer_from)
		var/mob/living/L = caller
		if(L.attack_flags & CONTROL_MOD_ALT) //SPLASH
			reagents.splash(caller,object,reagents.volume_current,FALSE,0.75)
			return TRUE

	if(can_feed(caller,object))
		PROGRESS_BAR(caller,src,self_feed ? BASE_FEED_TIME_SELF : BASE_FEED_TIME,.proc/feed,caller,object)
		PROGRESS_BAR_CONDITIONS(caller,src,.proc/can_feed,caller,object)
		return TRUE

	if(allow_reagent_transfer_from && is_item(object) && object.reagents)
		var/obj/item/I = object
		if(I.allow_reagent_transfer_to)
			if(reagents.volume_current <= 0)
				caller.to_chat(span("warning","\The [src.name] is empty!"))
				return FALSE
			if(object.reagents.volume_current >= object.reagents.volume_max)
				caller.to_chat(span("warning","\The [object.name] is full!"))
				return FALSE
			var/actual_transfer_amount = reagents.transfer_reagents_to(object.reagents,transfer_amount, caller = caller)
			caller.to_chat(span("notice","You transfer [actual_transfer_amount] units of liquid to \the [object]."))
			//TODO: Add liquid transfer sounds.
		return TRUE

	return FALSE

/obj/item/proc/can_feed(var/mob/caller,var/atom/target)

	INTERACT_CHECK_NO_DELAY(src)
	INTERACT_CHECK_NO_DELAY(target)

	if(!is_living(target))
		return FALSE

	if(is_living(caller))
		var/mob/living/C = caller
		if(C.attack_flags & CONTROL_MOD_ALT) //Splash
			return FALSE

	if(!reagents)
		return FALSE

	var/mob/living/L = target

	if(L.dead)
		caller.to_chat(span("warning","\The [L.name] is dead!"))
		return FALSE

	return TRUE

/obj/item/act_explode(var/atom/owner,var/atom/source,var/atom/epicenter,var/magnitude,var/desired_loyalty)

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

		throw_self(owner,null,null,null,x_mod*magnitude*2,y_mod*magnitude*2)

	return ..()

/obj/item/proc/get_overlay_ids()
	return list("\ref[src]")

/obj/item/proc/can_block()
	return TRUE

/obj/item/proc/can_parry()
	return TRUE

/obj/item/proc/get_battery()
	return null


/obj/item/can_attack(var/atom/victim,var/atom/weapon,var/params,var/damagetype/damage_type)
	if(quality <= 0)
		return FALSE
	return ..()

/obj/item/attack(var/atom/attacker,var/atom/victim,var/list/params=list(),var/atom/blamed,var/ignore_distance = FALSE, var/precise = FALSE,var/damage_multiplier=1) //The src attacks the victim, with the blamed taking responsibility
	damage_multiplier *= FLOOR(quality/100,0.01)
	return ..()