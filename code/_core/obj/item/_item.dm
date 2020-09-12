/obj/item/
	name = "item"
	desc = "Oh my god it's an item."

	var/last_marker //The last person to name this item. Used for moderation purposes.

	layer = LAYER_OBJ_ITEM

	var/vendor_name = null //Name for the vender. Set to null for it to just use the initial name var.

	var/rarity = RARITY_COMMON

	var/size = 1

	var/list/material = list() //Stored materials

	damage_type = null

	var/delete_on_drop = FALSE

	var/item_count_current = 1
	var/item_count_max = 1
	var/item_count_max_icon = 0

	var/slowdown_mul_held = 1 //Slow down multiplier. High values means more slower.
	var/slowdown_mul_worn = 1

	var/pixel_height = 2 //The z size of this, in pixels. Used for sandwiches and burgers.

	var/is_container = FALSE //Setting this to true will open the below inventories on use.
	var/dynamic_inventory_count = 0
	var/container_max_size = 0 //This item has a container, how much should it be able to hold in each slot?
	var/container_held_slots = 0 //How much each inventory slot can hold.
	var/container_blacklist = list()
	var/container_whitelist = list()

	var/container_temperature = 0 //How much to add or remove from the ambient temperature for calculating reagent temperature. Use for coolers.
	var/container_temperature_mod = 1 //The temperature mod of the inventory object. Higher values means faster temperature transition. Lower means slower.

	var/list/obj/hud/inventory/inventories = list() //The inventory holders this object has

	icon_state = "inventory"
	var/icon_state_held_left = "held_left"
	var/icon_state_held_right = "held_right"
	var/icon_state_worn = "worn"
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

	var/drop_sound = 'sound/items/drop/accessory.ogg'

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

	var/consume_size = BITE_SIZE

/obj/item/Crossed(var/atom/movable/O,var/atom/new_loc,var/atom/old_loc)
	return TRUE

/obj/item/Cross(var/atom/movable/O,var/atom/new_loc,var/atom/old_loc)
	return TRUE

/obj/item/PostInitialize()
	. = ..()
	if(length(polymorphs))
		update_sprite()
	return .

/obj/item/get_base_value()
	return initial(value) * item_count_current * price_multiplier

/obj/item/proc/get_slowdown_mul_held()
	return slowdown_mul_held

/obj/item/proc/get_slowdown_mul_worn()
	return slowdown_mul_worn

/obj/item/proc/transfer_item_count_to(var/obj/item/target,var/amount_to_transfer = item_count_current)
	if(!amount_to_transfer) return 0
	if(amount_to_transfer < 0) return target.transfer_item_count_to(src,-amount_to_transfer)
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
		drop_item()

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
		if(bypass && length(I.held_objects) >= I.held_slots)
			continue
		if(I.can_hold_object(object,enable_messages))
			return I

	return null

/obj/item/proc/add_to_inventory(var/mob/caller,var/obj/item/object,var/enable_messages = TRUE,var/bypass = FALSE) //We add the object to this item's inventory.

	if(!length(inventories))
		return FALSE

	var/added = FALSE

	if(object != src)
		var/obj/hud/inventory/found_inventory = can_add_to_inventory(caller,object,FALSE,bypass)
		if(found_inventory)
			found_inventory.add_object(object,enable_messages,bypass)
			added = TRUE

	if(enable_messages && caller)
		if(added)
			caller.to_chat(span("notice","You stuff \the [object.name] in \the [src.name]."))
		else
			caller.to_chat(span("warning","You don't have enough inventory space inside \the [src.name] to hold \the [object.name]!"))

	return added

/obj/item/New(var/desired_loc)

	if(!damage_type || damage_type == /damagetype/default/)
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
		if(container_held_slots)
			inventories[i].held_slots = container_held_slots
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
		var/obj/hud/inventory/dynamic/D = new(src)
		//Doesn't need to be initialized as it's done later.
		D.id = "dynamic_[i]"
		D.slot_num = i
		if(container_held_slots)
			D.held_slots = container_held_slots
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
	. += div("rarity","Value: [CEILING(calculate_value(TRUE),1)].")
	. += div("weightsize","Size: [size]")
	if(item_count_current > 1) . += div("weightsize","Quantity: [item_count_current].")
	var/worn_slowdown = get_slowdown_mul_worn()
	if(worn_slowdown > 1)//Slower
		. += div("red bold center","Worn Speed Penalty: [FLOOR((worn_slowdown-1)*100,1)]%")
	else if(worn_slowdown < 1)//Faster
		. += div("green bold center","Worn Speed Boost: [FLOOR((1/worn_slowdown)*100,1)-100]%")
	var/held_slowdown = get_slowdown_mul_held()
	if(held_slowdown > 1)//Slower
		. += div("red bold center","Held Speed Penalty: [FLOOR((held_slowdown-1)*100,1)]%")
	else if(held_slowdown < 1)//Faster
		. += div("green bold center","Held Speed Boost: [FLOOR((1/held_slowdown)*100,1)-100]%")
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

	A.update_lighting()

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

	return TRUE

/obj/item/proc/pre_pickup(var/atom/old_location,var/obj/hud/inventory/new_location) //When the item is picked up or worn.
	return TRUE

/obj/item/set_light(range,power,color,angle,no_update)
	. = ..()
	update_lighting_for_owner()
	return .

/obj/item/proc/on_drop(var/obj/hud/inventory/old_inventory,var/atom/new_loc)

	if(additional_clothing_parent)
		src.force_move(additional_clothing_parent)

	if(light)
		light.update(src)

	if(old_inventory && new_loc)
		var/turf/OL = get_turf(old_inventory)
		var/turf/NL = get_turf(new_loc)
		if(OL != NL)
			new/obj/effect/temp/item_pickup(NL,2,OL,src,isturf(new_loc) ? "drop" : "transfer")

	update_lighting_for_owner(old_inventory)

	if(drop_sound && isturf(loc) && !qdeleting)
		play(drop_sound,get_turf(src))

	return TRUE

/obj/item/proc/inventory_to_list()

	var/list/returning_list = list()

	for(var/k in inventories)
		var/obj/hud/inventory/I = k
		if(length(I.held_objects) && I.held_objects[1])
			returning_list += I.held_objects[1]

	return returning_list


/obj/item/proc/can_be_held(var/mob/living/advanced/owner,var/obj/hud/inventory/I)
	if(delete_on_drop)
		return FALSE
	if(anchored)
		return FALSE
	return TRUE

/obj/item/proc/can_be_worn(var/mob/living/advanced/owner,var/obj/hud/inventory/I)
	return FALSE


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

/obj/item/proc/get_reagents_to_consume()
	var/reagent_container/temp/T = new(src,1000)
	reagents.transfer_reagents_to(T,consume_size)
	return T.qdeleting ? null : T

/obj/item/proc/feed(var/mob/caller,var/mob/living/target)
	if(reagents && can_feed(caller,target))
		var/reagent_container/R = get_reagents_to_consume()
		if(R) R.consume(caller,target)
		return TRUE
	return FALSE

/obj/item/proc/try_transfer_reagents(var/mob/caller,var/atom/object,var/location,var/control,var/params)

	var/atom/defer_object = object.defer_click_on_object(location,control,params)

	if(is_living(caller) && allow_reagent_transfer_from)
		var/mob/living/L = caller
		if(L.intent == INTENT_HARM) //SPLASH
			reagents.splash(caller,object)
			return TRUE

	if(can_feed(caller,defer_object))
		PROGRESS_BAR(caller,src,SECONDS_TO_DECISECONDS(1),.proc/feed,caller,defer_object)
		PROGRESS_BAR_CONDITIONS(caller,src,.proc/can_feed,caller,defer_object)
		return TRUE

	if(allow_reagent_transfer_from && is_item(defer_object) && defer_object.reagents)
		var/obj/item/I = defer_object
		if(I.allow_reagent_transfer_to)
			if(reagents.volume_current <= 0)
				caller.to_chat(span("warning","\The [src.name] is empty!"))
				return FALSE
			if(defer_object.reagents.volume_current >= defer_object.reagents.volume_max)
				caller.to_chat(span("warning","\The [defer_object.name] is full!"))
				return FALSE
			var/actual_transfer_amount = reagents.transfer_reagents_to(defer_object.reagents,transfer_amount)
			caller.to_chat(span("notice","You transfer [actual_transfer_amount] units of liquid to \the [defer_object]."))
		return TRUE

	return FALSE

/obj/item/proc/can_feed(var/mob/caller,var/atom/target)

	if(!is_living(target))
		return FALSE

	if(is_living(caller))
		var/mob/living/C = caller
		if(C.intent != INTENT_HELP)
			return FALSE

	if(!reagents)
		return FALSE

	var/mob/living/L = target

	if(get_dist(caller,target) > 1)
		caller?.to_chat(span("warning","They're too far away!"))
		return FALSE

	if(caller != target && L.ckey_last && !L.ckey && !L.dead)
		caller.to_chat(span("warning","\The [L.name]'s mouth is locked shut! They must be suffering from Space Sleep Disorder..."))
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