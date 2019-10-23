/obj/item/
	name = "item"
	desc = "Oh my god it's an item."

	var/rarity = RARITY_COMMON

	var/size = SIZE_1
	var/weight = WEIGHT_1

	var/value = 1 //Value in whatever currency this world uses. Used for buying and selling items.

	var/delete_on_drop = FALSE

	var/item_count_current = 1
	var/item_count_max = 1
	var/item_count_max_icon = 0

	var/slowdown_mul_held = 1 //Slow down multiplier. High values means more slower.
	var/slowdown_mul_worn = 1


	var/is_container = FALSE //Setting this to true will open the below inventories on use.
	var/dynamic_inventory_count = 0
	var/container_max_size = 0 //This item has a container, how much should it be able to hold in each slot?
	var/container_max_weight = 0 //This item has a container, how much should it be able to carry in TOTAL?
	var/container_held_slots = 0 //How much each inventory slot can hold.
	var/container_blacklist = list()
	var/container_whitelist = list()

	var/list/obj/hud/inventory/inventories = list() //The inventory holders this object has

	icon_state = "inventory"
	var/icon_state_held_left = "held_left"
	var/icon_state_held_right = "held_right"
	var/icon_state_worn = "worn"

	var/worn_layer = 0

	var/item_slot = SLOT_NONE

	mouse_over_pointer = MOUSE_ACTIVE_POINTER

	var/no_held_draw = FALSE

	var/no_initial_blend = FALSE //Should we draw the initial icon when worn/held?

	var/slot_icons = FALSE //Set to true if the clothing is based on where it's slot is.

	var/ignore_other_slots = FALSE

	var/block_mul = list(
		ATTACK_TYPE_MELEE = 0,
		ATTACK_TYPE_RANGED = 0,
		ATTACK_TYPE_MAGIC = 0
	)

	var/parry_mul = list(
		ATTACK_TYPE_MELEE = 0,
		ATTACK_TYPE_RANGED = 0,
		ATTACK_TYPE_MAGIC = 0
	)

	var/soul_bound = null

	var/has_quick_function = FALSE
	var/quick_function_type =  FLAG_QUICK_INSTANT
	//FLAG_QUICK_INSTANT
	//FLAG_QUICK_TOGGLE

	var/list/inventory_bypass = list()

	var/crafting_id = null

	var/list/inventory_sounds = list(
		'sounds/effects/inventory/rustle1.ogg',
		'sounds/effects/inventory/rustle2.ogg',
		'sounds/effects/inventory/rustle3.ogg',
		'sounds/effects/inventory/rustle4.ogg',
		'sounds/effects/inventory/rustle5.ogg'
	)

	var/list/alchemy_reagents = list() //Reagents that are created if this is processed in an alchemy table. Format: reagent_id = volume.

	var/flags_tool = FLAG_TOOL_NONE
	var/tool_time = SECONDS_TO_DECISECONDS(5)

	var/worn_pixel_x = 0
	var/worn_pixel_y = 0

/obj/item/destroy()

	for(var/obj/hud/inventory/I in inventories)
		qdel(I)

	inventories.Cut()

	return ..()


/obj/item/proc/quick(var/mob/living/advanced/caller,var/atom/object,location,control,params)
	return FALSE

/obj/item/can_be_attacked(var/atom/attacker)
	return FALSE

/obj/item/click_self(caller,location,control,params)

	if(!length(inventories))
		return FALSE

	var/mob/living/advanced/A = caller

	for(var/obj/hud/inventory/I in A.inventory)
		if(I in inventories)
			continue
		if(!(I.flags & FLAGS_HUD_CONTAINER))
			continue
		I.alpha = 0
		I.mouse_opacity = 0

	var/opening = FALSE

	var/should_center = length(inventories) <= 8

	for(var/i=1,i<=length(inventories),i++)
		var/obj/hud/inventory/I = inventories[i]
		I.update_owner(A)

		if(should_center)
			I.screen_loc = "CENTER+[i]-[(length(inventories)+1)/2],BOTTOM+1.25"
		else
			I.screen_loc = "CENTER+[-MAX_INVENTORY_X*0.5 + i - 0.5 - floor((i-1)/MAX_INVENTORY_X)*MAX_INVENTORY_X],BOTTOM+[1.25 + floor((i-1)/MAX_INVENTORY_X)]"

		if(opening || !I.alpha)
			animate(I,alpha=255,time=4)
			I.mouse_opacity = 2
			opening = TRUE
		else
			animate(I,alpha=0,time=4)
			I.mouse_opacity = 0
			opening = FALSE

	if(opening)
		for(var/obj/hud/button/close_inventory/B in A.buttons)
			B.alpha = 0
			B.mouse_opacity = 0

		var/turf/T = get_turf(src)
		var/area/A2 = get_area(T)
		play_sound(pick(inventory_sounds),all_mobs_with_clients,vector(T.x,T.y,T.z),environment = A2.sound_environment, channel = SOUND_CHANNEL_FX)

	for(var/obj/hud/button/close_inventory/B in A.buttons)

		if(should_center)
			B.screen_loc = "CENTER+[(length(inventories)+1)/2],BOTTOM+1.25"
		else
			B.screen_loc = "CENTER+[0.5+MAX_INVENTORY_X*0.5],BOTTOM+1.25"

		if(opening)
			animate(B,alpha=255,time=4)
			B.mouse_opacity = 2
		else
			animate(B,alpha=0,time=4)
			B.mouse_opacity = 0

		break

	return TRUE

/obj/item/clicked_on_by_object(var/mob/caller as mob,var/atom/object,location,control,params) //The src was clicked on by the object

	if(is_container)

		if(is_inventory(src.loc) && !is_dynamic_inventory(src.loc) && is_inventory(object) && is_advanced(caller) && length(inventories) && get_dist(caller,src) <= 1 && click_self(caller,location,control,params)) //Open the inventory
			return TRUE

		if(is_inventory(object))
			src.transfer_item(object)
			return TRUE

		if(is_item(object)) //Add to the inventory
			add_to_inventory(caller,object,TRUE)
			return TRUE

	return 	..()

/obj/item/drop_on_object(var/atom/caller,var/atom/object)

	if(caller == object)
		return click_self(caller)

	return ..()

/obj/item/proc/add_to_inventory(var/mob/caller,var/obj/item/object,var/enable_messages = TRUE) //We add the object to this item's inventory.

	if(!length(inventories))
		return FALSE

	var/added = FALSE

	if(object != src)
		for(var/obj/hud/inventory/I in inventories)
			if(I.add_object(object,FALSE))
				added = TRUE
				break

	if(enable_messages && caller)
		if(added)
			caller.to_chat(span("notice","You stuff \the [object.name] in \the [src.name]."))
		else
			caller.to_chat(span("warning","You don't have enough inventory space inside \the [src.name] to hold \the [object.name]!"))

	return added

/obj/item/New(var/desired_loc)

	for(var/i=1, i <= length(inventories), i++)
		var/obj/hud/inventory/new_inv = inventories[i]
		inventories[i] = new new_inv(src)

		if(container_held_slots)
			inventories[i].held_slots = container_held_slots
		if(container_max_size)
			inventories[i].max_size = container_max_size
		if(container_max_weight)
			inventories[i].max_weight = container_max_weight
		if(container_blacklist)
			inventories[i].item_blacklist = container_blacklist
		if(container_whitelist)
			inventories[i].item_whitelist = container_whitelist

	for(var/i=1, i <= dynamic_inventory_count, i++)
		var/obj/hud/inventory/dynamic/D = new(src)
		D.id = "dynamic_[i]"
		D.slot_num = i
		if(container_held_slots)
			D.held_slots = container_held_slots
		if(container_max_size)
			D.max_size = container_max_size
		if(container_max_weight)
			D.max_weight = container_max_weight
		if(container_blacklist)
			D.item_blacklist = container_blacklist
		if(container_whitelist)
			D.item_whitelist = container_whitelist
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

/obj/item/update_icon()
	. = ..()
	if(is_inventory(src.loc))
		var/obj/hud/inventory/I = src.loc
		I.update_icon()
	return .

/obj/item/get_examine_text(var/mob/examiner)
	var/name_text = div("examine_title",src.name)
	var/rarity_text = div("rarity [rarity]",capitalize(rarity))
	var/physical_text = div("weightsize","Size: [size] | Weight: [weight]")
	var/desc_text = div("examine_description","\"[src.desc]\"")
	var/desc_extended_text = div("examine_description_long",src.desc_extended)
	var/damage_type_text = get_damage_type_text(examiner)
	return "[name_text][desc_text][rarity_text][physical_text][desc_extended_text][damage_type_text]"


obj/item/proc/do_automatic(caller,object,location,params)
	return TRUE

/obj/item/proc/update_lighting_for_owner(var/obj/hud/inventory/inventory_override)

	var/obj/hud/inventory/I = inventory_override || src.loc

	if(!I || !is_inventory(I))
		return FALSE

	if(!I.owner || !is_advanced(I.owner))
		return FALSE

	var/mob/living/advanced/A = I.owner

	A.update_lighting()

	return TRUE

/obj/item/proc/on_pickup(var/atom/old_location,var/obj/hud/inventory/new_location) //When the item is picked up.

	if(is_container)
		for(var/obj/hud/inventory/I in inventories)
			I.update_owner(new_location.owner)

	if(new_location)
		update_lighting_for_owner(new_location)

	return TRUE

/obj/item/set_light(range,power,color,angle,no_update)
	. = ..()
	update_lighting_for_owner()
	return .

/obj/item/proc/on_drop(var/obj/hud/inventory/old_inventory,var/atom/new_loc)

	if(delete_on_drop)
		qdel(src)
		return TRUE

	if(light)
		light.update(src)

	update_lighting_for_owner(old_inventory)

	return TRUE

/obj/item/proc/inventory_to_list()

	var/list/returning_list = list()

	for(var/obj/hud/inventory/I in inventories)
		if(length(I.held_objects) && I.held_objects[1])
			returning_list += I.held_objects[1]

	return returning_list


/obj/item/proc/can_be_held(var/mob/living/advanced/owner,var/obj/hud/inventory/I)
	return TRUE

/obj/item/proc/can_be_worn(var/mob/living/advanced/owner,var/obj/hud/inventory/I)
	return FALSE

/obj/item/proc/get_damage_type() //Information purposes only.
	return damage_type

/obj/item/proc/update_held_icon()

	if(is_inventory(src.loc))
		var/obj/hud/inventory/I = src.loc
		I.update_held_icon(src)

	return TRUE