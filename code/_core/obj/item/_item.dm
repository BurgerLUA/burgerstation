/obj/item/
	name = "item"
	desc = "Oh my god it's an item."

	vis_flags = VIS_INHERIT_PLANE | VIS_INHERIT_DIR | VIS_INHERIT_ID

	var/value_burgerbux

	var/contraband = FALSE //Set to true if this object is considered contraband and can't be saved, but still accessed by the game.
	var/save_on_death = FALSE //Set to true if this item should save on death, regardless of item respawning.


	var/can_rename = FALSE //Can you rename this item?

	var/last_marker //The last person to name this item. Used for moderation purposes.

	plane = PLANE_ITEM
	layer = LAYER_OBJ_ITEM

	var/vendor_name = null //Name for the vender. Set to null for it to just use the initial name var.

	size = SIZE_0
	var/weight = 0 //DEPRICATED
	var/quality = 100
	var/rarity = RARITY_COMMON //Arbitrary Value
	var/tier = -1 //-1 means not set.
	var/tier_type = "item"

	var/list/material = list() //Stored materials

	damage_type = null

	var/delete_on_drop = FALSE

	var/amount = 1
	var/amount_max = 1
	var/amount_max_icon = 0

	var/pixel_height = 2 //The z size of this, in pixels. Used for sandwiches and burgers.
	var/pixel_height_offset = 0 //The z offset of this, in pixels. Used for sandwiches and burgers.

	var/is_container = FALSE //Setting this to true will open the below inventories on use.
	var/dynamic_inventory_count = 0
	var/obj/hud/inventory/dynamic/dynamic_inventory_type = /obj/hud/inventory/dynamic
	var/container_max_size = 0 //This item has a container, how much should it be able to hold in each slot?
	var/container_max_slots = 0 //How much each inventory slot can hold.
	var/container_blacklist = list()
	var/container_whitelist = list()
	var/max_inventory_x = MAX_INVENTORY_X
	var/inventory_category = "dynamic"
	var/starting_inventory_y = "BOTTOM:12+1.25"
	var/inventory_y_multiplier = 1

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

	var/list/alchemy_reagents = list() //Reagents that are created if this is processed in an alchemy table. Format: reagent_type = volume.

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

	value = -1

	allow_path = TRUE

	var/can_save = TRUE

	var/uses_until_condition_fall = 0 //Uses until the quality degrades by 1%. 0 to disable. For clothing it's "How much damage equals -1% quality."

	enable_chunk_clean = TRUE

	var/enable_blood_stains = FALSE //Set to false to disable. Good for laser weapons.
	var/blood_stain_intensity = 0 //Scale, from 0 to 5.
	var/blood_stain_color //Bloodstain color, if any.

	var/enable_damage_overlay = FALSE
	var/enable_torn_overlay = FALSE

	var/no_drop = FALSE //Set to true if you're unable to drop this item via normal means.

	var/combat_range = 1 //Maximum ideal combat range for the weapon.

	var/can_negate_damage = FALSE

/obj/item/Destroy()

	additional_clothing_parent = null

	if(inventory_user)
		close_inventory(inventory_user)
		inventory_user = null //Just in case

	QDEL_CUT(inventories)

	last_interacted = null
	inventory_user = null

	if(loc)
		drop_item(silent=TRUE)

	can_save = FALSE
	can_hold = FALSE
	can_wear = FALSE
	unremovable = TRUE

	. = ..()

var/global/list/rarity_to_prob = list(
	RARITY_COMMON = 80,
	RARITY_UNCOMMON = 20,
	RARITY_RARE = 4,
	RARITY_MYTHICAL = 1
)

var/global/list/rarity_to_mul = list(
	RARITY_COMMON = 1,
	RARITY_UNCOMMON = 2,
	RARITY_RARE = 3,
	RARITY_MYTHICAL = 4
)

/obj/item/proc/generate_rarity() //Only called when loot is spawned. Not in shops or other means.
	if(rarity == RARITY_COMMON) rarity = pickweight(rarity_to_prob)
	if(uses_until_condition_fall > 0) quality += (rarity_to_mul[rarity]-1)*10
	return TRUE

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

/obj/item/Crossed(atom/movable/O)
	return TRUE

/obj/item/Cross(atom/movable/O,atom/oldloc)
	return TRUE

/obj/item/Finalize()
	. = ..()
	if(length(polymorphs) || color != initial(color))
		update_sprite()
	if(!crafting_id)
		crafting_id = src.type

/obj/item/proc/get_damage_icon_number(var/desired_quality = quality)
	return FLOOR(clamp( (100 - quality) / (100/5),0,5 ),1)

/obj/item/initialize_blends(var/desired_icon_state)

	if(!desired_icon_state)
		desired_icon_state = icon_state_worn

	if(length(polymorphs))
		var/icon/initial_icon = initial(icon)
		for(var/polymorph_name in polymorphs)
			var/polymorph_color = polymorphs[polymorph_name]
			add_blend(
				"polymorph_[polymorph_name]",
				desired_icon = initial_icon,
				desired_icon_state = "[desired_icon_state]_[polymorph_name]",
				desired_color = polymorph_color,
				desired_blend = ICON_OVERLAY,
				desired_type = ICON_BLEND_OVERLAY,
				desired_should_save = TRUE,
				desired_layer = worn_layer
			)

	if(enable_blood_stains)
		add_blend(
			"bloodstain",
			desired_icon = 'icons/mob/living/advanced/overlays/blood_overlay.dmi',
			desired_icon_state = blood_stain_intensity ? "[CEILING(blood_stain_intensity,1)]" : null,
			desired_color = blood_stain_color,
			desired_blend = ICON_ADD,
			desired_type = ICON_BLEND_MASK,
			desired_should_save = FALSE,
			desired_layer = worn_layer+0.01
		)

	if(enable_damage_overlay)
		var/desired_damage_num = get_damage_icon_number()
		add_blend(
			"damage_overlay_noise",
			desired_icon = 'icons/mob/living/advanced/overlays/damage_clothing.dmi',
			desired_icon_state = desired_damage_num ? "[desired_damage_num]" : null,
			desired_blend = ICON_MULTIPLY,
			desired_type = ICON_BLEND_MASK,
			desired_should_save = FALSE,
			desired_layer = worn_layer+0.02
		)

	if(enable_torn_overlay)
		var/desired_damage_num = max(0,get_damage_icon_number() - 1)
		add_blend(
			"damage_overlay",
			desired_icon = 'icons/mob/living/advanced/overlays/damage_overlay.dmi',
			desired_icon_state = desired_damage_num ? "[desired_damage_num]" : null,
			desired_blend = ICON_OVERLAY,
			desired_type = ICON_BLEND_CUT,
			desired_should_save = FALSE,
			desired_layer = worn_layer+0.03
		)

	. = ..()

/obj/item/get_base_value()
	return initial(value) * amount * price_multiplier * (0.5 + 0.5*clamp(quality/100,0.25,1.5))

/obj/item/proc/transfer_amount_to(var/obj/item/target,var/amount_to_transfer = amount)
	if(!amount_to_transfer) return 0
	if(amount_to_transfer < 0)
		return target.transfer_amount_to(src,-amount_to_transfer)
	amount_to_transfer = min(
		amount_to_transfer, //What we want to transfer
		amount, //What we can actually transfer from
		target.amount_max - target.amount //What the target can actually hold.
	)
	return target.add_item_count(-src.add_item_count(-amount_to_transfer,TRUE),TRUE)

/obj/item/get_inaccuracy(var/atom/source,var/atom/target,var/inaccuracy_modifier) //Only applies to melee. For ranged, see /obj/item/weapon/ranged/proc/get_bullet_inaccuracy(var/mob/living/L,var/atom/target)
	if(is_living(source))
		var/mob/living/L = source
		return (1 - L.get_skill_power(SKILL_PRECISION,0,0.5,1))*inaccuracy_modifier*8
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
		if(I.can_slot_object(object,enable_messages,bypass))
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

	for(var/i=1, i <= dynamic_inventory_count, i++)
		var/obj/hud/inventory/dynamic/D = new dynamic_inventory_type(src)
		//Doesn't need to be initialized as it's done later.
		D.id = "\ref[src]_dynamic_[i]"
		D.slot_num = i
		D.inventory_category = inventory_category
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

	if(contraband)
		. += div("bad bold","CONTRABAND")

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

	. += div("rarity","Base Value: [get_base_value()]cr.")
	. += div("weightsize","Size: [size], Weight: [weight]")

	if(amount > 1) . += div("weightsize","Quantity: [amount].")
	. += div("examine_description","\"[src.desc]\"")
	. += div("examine_description_long",src.desc_extended)


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

	if(is_container && inventory_user)
		if(is_inventory(old_loc) && is_inventory(loc))
			var/obj/hud/inventory/I1 = old_loc
			var/obj/hud/inventory/I2 = loc
			if(I1.owner != I2.owner)
				close_inventory(null)
		else if(!can_interact_with_inventory(inventory_user))
			close_inventory(null)

	if(isturf(loc) && is_inventory(old_loc))
		if(delete_on_drop)
			qdel(src)
			return TRUE
	else
		undelete(src)

	. = ..()

/obj/item/proc/on_pickup(var/atom/old_location,var/obj/hud/inventory/new_location) //When the item is picked up or worn.

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

/obj/item/set_light(l_range, l_power, l_color = NONSENSICAL_VALUE, angle = NONSENSICAL_VALUE, no_update = FALSE,debug = FALSE)
	. = ..()
	update_lighting_for_owner()

/obj/item/set_light_sprite(l_range, l_power, l_color = NONSENSICAL_VALUE, angle = NONSENSICAL_VALUE, no_update = FALSE,debug = FALSE)
	. = ..()
	update_lighting_for_owner()
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
		PROGRESS_BAR(caller,src,self_feed ? BASE_FEED_TIME_SELF : BASE_FEED_TIME,.proc/feed,caller,object)
		PROGRESS_BAR_CONDITIONS(caller,src,.proc/can_feed,caller,object)
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

	if(is_living(caller))
		var/mob/living/C = caller
		if(C.attack_flags & CONTROL_MOD_DISARM) //Splash
			return FALSE
		if(reagents.contains_lethal && L != C)
			var/area/A = get_area(L)
			if(!allow_hostile_action(C.loyalty_tag,L.loyalty_tag,A))
				caller.to_chat(span("warning","Your loyalties prevent you from feeding dangerous reagents to your allies!"))
				return FALSE

	if(L.dead)
		caller.to_chat(span("warning","\The [L.name] is dead!"))
		return FALSE

	return TRUE

/obj/item/act_explode(var/atom/owner,var/atom/source,var/atom/epicenter,var/magnitude,var/desired_loyalty_tag)

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

	return ..()

/obj/item/proc/get_overlay_ids()
	return list("\ref[src]")

/obj/item/proc/can_block()
	return TRUE

/obj/item/proc/can_parry()
	return TRUE

/obj/item/proc/get_battery()
	return null


/obj/item/can_attack(var/atom/attacker,var/atom/victim,var/atom/weapon,var/params,var/damagetype/damage_type)
	if(quality <= 0)
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

	if(!enable_blood_stains || desired_level <= 0)
		remove_blend("bloodstain")
		return TRUE

	//Store the old values.
	var/old_level = blood_stain_intensity
	var/old_color = blood_stain_color

	//Set the new values.
	blood_stain_intensity = desired_level
	if(desired_color)
		blood_stain_color = desired_color

	//If the old values are the same as the new levels, don't even bother doing an update.
	if(!force && CEILING(old_level,1) == CEILING(blood_stain_intensity,1) && old_color == desired_color)
		return FALSE

	add_blend("bloodstain", desired_icon_state = blood_stain_intensity > 0 ? "[CEILING(blood_stain_intensity,1)]" : null, desired_color = blood_stain_color)
	update_sprite()

	if(is_inventory(loc))
		var/obj/hud/inventory/I = loc
		if(I.worn && is_advanced(I.owner))
			var/mob/living/advanced/A = I.owner
			A.remove_overlay("\ref[src]")
			I.update_worn_icon(src)

	return TRUE

/obj/item/update_icon()
	. = ..()
	if(length(polymorphs))
		icon = null

/obj/item/update_overlays()

	. = ..()

	for(var/polymorph_name in polymorphs)
		var/polymorph_color = polymorphs[polymorph_name]
		var/image/I = new/image(initial(icon),"[icon_state]_[polymorph_name]")
		I.color = polymorph_color
		add_overlay(I)

	if(enable_blood_stains && blood_stain_intensity > 0 && blood_stain_color)
		var/image/I = new/image('icons/mob/living/advanced/overlays/blood_overlay.dmi',"[CEILING(blood_stain_intensity,1)]")
		I.appearance_flags = src.appearance_flags | RESET_COLOR
		I.blend_mode = BLEND_INSET_OVERLAY
		I.color = blood_stain_color
		add_overlay(I)


/obj/item/proc/get_quality_bonus(var/minimum=0.5,var/maximum=2,var/threshold=60)
	var/quality_mod_to_use
	if(quality < 100)
		quality_mod_to_use = min(1,quality/threshold) //Start failing only below the threshold.
	else
		quality_mod_to_use = quality/100
	quality_mod_to_use = FLOOR(quality_mod_to_use,0.01)
	return min(minimum + quality_mod_to_use*(1-minimum),maximum)

/obj/item/proc/adjust_quality(var/quality_to_add=0)

	var/original_quality = quality
	var/original_damage_num = get_damage_icon_number()

	quality = FLOOR(quality + quality_to_add,0.01)

	if(original_quality > 0 && quality <= 0)
		visible_message(span("danger","\The [src.name] breaks!"))

	if(enable_torn_overlay || enable_damage_overlay)
		var/desired_damage_num = get_damage_icon_number()
		if(original_damage_num != desired_damage_num)
			add_blend("damage_overlay_noise", desired_icon_state = desired_damage_num ? "[desired_damage_num]" : null)
			add_blend("damage_overlay", desired_icon_state = desired_damage_num ? "[desired_damage_num]" : null)
			update_sprite()
			if(is_inventory(loc))
				var/obj/hud/inventory/I = loc
				if(I.worn && is_advanced(I.owner))
					var/mob/living/advanced/A = I.owner
					A.remove_overlay("\ref[src]")
					I.update_worn_icon(src)

	return TRUE



/obj/item/dust(var/atom/source)
	qdel(src)
	return TRUE


/obj/item/proc/negate_damage(var/atom/attacker,var/atom/victim,var/atom/weapon,var/atom/hit_object,var/atom/blamed,var/damage_dealt=0)
	return FALSE