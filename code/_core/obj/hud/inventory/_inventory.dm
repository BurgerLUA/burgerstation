//Inventory system. Basically anything that can hold an object needs an inventory.

/obj/hud/inventory/
	name = "Inventory Holder"
	desc = "Inventory"
	id = "BADINVENTORY"

	//icon = 'icons/invisible.dmi'
	//icon_state = "0"

	icon = 'icons/hud/hud.dmi'
	icon_state = "square"

	plane = PLANE_HUD

	value = 0

	var/list/obj/item/held_objects //Items that are held, and not worn.
	var/list/obj/item/worn_objects //Items that are worn, and not held.
	var/atom/movable/grabbed_object

	var/held_slots = 1 //How many items this object can hold.
	var/max_weight = -1 //Maximum weight this inventory object can hold. -1 basically means it can't hold anything.
	var/max_size = -1 //Maximum amount of size this object can hold. -1 basically means it can't hold anything.

	var/worn_slots = 1 //How many items this object can wear
	var/worn_allow_duplicate = FALSE //Can you wear more than one item of the same slot at once?

	var/total_weight = 0 //Var storage value that is updated every time an item is changed.
	var/total_size = 0 //Var storage value that is updated every time an item is changed.

	var/item_slot = SLOT_NONE //Items that can be worn in this slot. Applies to clothing only.

	var/priority = 0 //The priority level of the inventory. Item transfer favors inventories with higher values.

	var/inventory_temperature_mod = 0 //How much to add or remove from the ambient temperature for calculating reagent temperature.
	var/inventory_temperature_mod_mod = 0.5 //The temperature mod of the inventory object. Higher values means faster temperature transition. Lower means slower. Zero means don't change from inventory.

	var/list/obj/item/item_blacklist = list() //Items that can't go in this invetory.
	var/list/obj/item/item_whitelist = list() //Items that can only go in this inventory.
	var/list/obj/item/item_bypass = list() //Items that bypass any size and weight requirements.

	var/click_flags

	var/flags = FLAGS_HUD_INVENTORY

	var/should_draw = TRUE //Should the item's held icon be displayed?

	var/drag_to_take = TRUE //You must click and drag to take the object inside.

	var/obj/hud/inventory/parent_inventory //Basically one massive defer to this inventory.
	var/obj/hud/inventory/child_inventory

	mouse_over_pointer = MOUSE_ACTIVE_POINTER
	mouse_drag_pointer = MOUSE_ACTIVE_POINTER
	mouse_drop_pointer = MOUSE_ACTIVE_POINTER
	mouse_drop_zone = 1

	mouse_opacity = 2

	var/essential = FALSE //Should this be drawn when the inventory is hidden?
	var/is_container = FALSE //Set to true if it uses the container inventory system.

	var/x_offset_initial = 0
	var/y_offset_initial = 0

	var/x_offset_mul = 0
	var/y_offset_mul = 0

	var/draw_extra = FALSE

	var/should_add_held = TRUE
	var/should_add_worn = TRUE

	var/drop_on_death = FALSE //Set to true if this inventory should drop all its contents when the owner dies.

	var/allow_quick_equip = TRUE

	interaction_flags = FLAG_INTERACTION_LIVING | FLAG_INTERACTION_NO_DISTANCE | FLAG_INTERACTION_NO_DISTANCE

/obj/hud/inventory/proc/is_occupied(var/ignore_held = TRUE, var/ignore_worn = TRUE)

	if(!ignore_held && get_top_held_object())
		return TRUE

	if(!ignore_worn && get_top_worn_object())
		return TRUE

	if(grabbed_object)
		return TRUE

	if(parent_inventory)
		return TRUE

	if(is_advanced(owner))
		var/mob/living/advanced/A = owner
		if(A.handcuffed)
			return TRUE

	return FALSE

/obj/hud/inventory/Destroy()

	if(grabbed_object)
		release_object()

	show(FALSE,0)

	remove_from_owner()

	for(var/obj/item/I in held_objects)
		qdel(I)
	held_objects.Cut()

	for(var/obj/item/I in worn_objects)
		qdel(I)
	worn_objects.Cut()

	owner = null

	parent_inventory = null
	child_inventory = null
	grabbed_object = null

	return ..()

/obj/hud/inventory/proc/show(var/should_show,var/speed)
	if(should_show)
		animate(src,alpha=255,time=SECONDS_TO_DECISECONDS(speed))
		src.mouse_opacity = 2
	else
		animate(src,alpha=0,time=SECONDS_TO_DECISECONDS(speed))
		src.mouse_opacity = 0

/obj/hud/inventory/New(var/desired_loc)
	held_objects = list()
	worn_objects = list()
	. = ..()
	update_sprite()
	return .

/obj/hud/inventory/can_be_attacked(var/atom/attacker,var/atom/weapon,var/params,var/damagetype/damage_type)
	return FALSE

/obj/hud/inventory/get_examine_list(var/atom/examiner)
	var/obj/item/I = get_top_object()
	if(!I)
		return list()
	return I.get_examine_list(examiner)

/obj/hud/inventory/update_overlays()

	. = ..()

	var/total_pixel_x = 0
	var/total_pixel_y = 0

	if(parent_inventory)
		color = "#ff0000"
		add_overlay(parent_inventory.overlays)
	else if(grabbed_object)
		color = "#ffff00"
		var/image/I = new/image(initial(icon),"grab")
		add_overlay(I)
	else
		color = initial(color)

	for(var/obj/item/I in held_objects)
		I.pixel_x = initial(I.pixel_x) + x_offset_initial + total_pixel_x*TILE_SIZE
		I.pixel_y = initial(I.pixel_y) + y_offset_initial + total_pixel_y*TILE_SIZE

		if(x_offset_mul)
			total_pixel_x += I.size*x_offset_mul

		if(y_offset_mul)
			total_pixel_y += I.size*y_offset_mul

		add_overlay(I)

	for(var/obj/item/I in worn_objects)
		I.pixel_x = initial(I.pixel_x) + x_offset_initial + total_pixel_x*TILE_SIZE
		I.pixel_y = initial(I.pixel_y) + y_offset_initial + total_pixel_y*TILE_SIZE

		if(x_offset_mul)
			total_pixel_x += I.size*x_offset_mul

		if(y_offset_mul)
			total_pixel_y += I.size*y_offset_mul

		add_overlay(I)

	return .

/obj/hud/inventory/proc/update_held_icon(var/obj/item/item_to_update)

	//OVERLAY BUG, NOT THIS.
	if(!owner || !is_advanced(owner) || !item_to_update)
		return FALSE

	var/mob/living/advanced/A = owner

	var/icon/desired_icon = initial(item_to_update.icon)
	var/desired_icon_state = null
	var/desired_pixel_x = 0
	var/desired_pixel_y = 0
	var/desired_layer = LAYER_MOB_HELD
	var/matrix/desired_transform = matrix()

	var/list/states = icon_states(initial(item_to_update.icon))

	if(item_to_update.dan_mode)
		desired_icon_state = item_to_update.dan_icon_state
		switch(owner.dir)
			if(NORTH)
				desired_layer = item_to_update.dan_layer_below
				desired_pixel_x = click_flags & RIGHT_HAND ? item_to_update.dan_offset_pixel_x[1] : -item_to_update.dan_offset_pixel_x[1]
				desired_pixel_y = click_flags & RIGHT_HAND ? item_to_update.dan_offset_pixel_y[1] : -item_to_update.dan_offset_pixel_y[1]
				if(click_flags & RIGHT_HAND)
					desired_transform.Scale(-1,1)
			if(EAST)
				desired_layer = click_flags & RIGHT_HAND ? item_to_update.dan_layer_above : item_to_update.dan_layer_below
				desired_pixel_x = click_flags & RIGHT_HAND ? item_to_update.dan_offset_pixel_x[2] : -item_to_update.dan_offset_pixel_x[2] + 4
				desired_pixel_y = click_flags & RIGHT_HAND ? item_to_update.dan_offset_pixel_y[2] : -item_to_update.dan_offset_pixel_y[2]
				desired_transform.Scale(-1,1)
			if(SOUTH)
				desired_layer = item_to_update.dan_layer_above
				desired_pixel_x = click_flags & RIGHT_HAND ? item_to_update.dan_offset_pixel_x[3] : -item_to_update.dan_offset_pixel_x[3]
				desired_pixel_y = click_flags & RIGHT_HAND ? item_to_update.dan_offset_pixel_y[3] : -item_to_update.dan_offset_pixel_y[3]
				if(click_flags & LEFT_HAND)
					desired_transform.Scale(-1,1)
			if(WEST)
				desired_layer = click_flags & RIGHT_HAND ? item_to_update.dan_layer_below : item_to_update.dan_layer_above
				desired_pixel_x = click_flags & RIGHT_HAND ? item_to_update.dan_offset_pixel_x[4] - 4 : -item_to_update.dan_offset_pixel_x[4]
				desired_pixel_y = click_flags & RIGHT_HAND ? item_to_update.dan_offset_pixel_y[4] : -item_to_update.dan_offset_pixel_y[4]
				//desired_transform.Scale(-1,1)
	else if(id == BODY_HAND_LEFT)
		desired_icon_state = item_to_update.icon_state_held_left
	else if(id == BODY_HAND_RIGHT)
		desired_icon_state = item_to_update.icon_state_held_right

	if(desired_icon_state == null)
		return FALSE

	if(length(item_to_update.polymorphs))
		var/icon/I = ICON_INVISIBLE
		for(var/polymorph_name in item_to_update.polymorphs)
			var/polymorph_color = item_to_update.polymorphs[polymorph_name]
			if(!("[desired_icon_state]_[polymorph_name]" in states))
				continue
			var/icon/I2 = new /icon(desired_icon,"[desired_icon_state]_[polymorph_name]")
			I2.Blend(polymorph_color,ICON_MULTIPLY)
			I.Blend(I2,ICON_OVERLAY)
		desired_icon_state = null
		desired_icon = I
	else if(!(desired_icon_state in states))
		return FALSE

	if(!A.overlays_assoc["\ref[item_to_update]"])
		A.add_overlay_tracked(
			"\ref[item_to_update]",
			item_to_update,
			desired_icon = desired_icon,
			desired_icon_state = desired_icon_state,
			desired_layer = desired_layer,
			desired_never_blend = TRUE,
			desired_color = item_to_update.color,
			desired_pixel_x = desired_pixel_x,
			desired_pixel_y = desired_pixel_y,
			desired_transform = desired_transform
		)
	else
		A.update_overlay_tracked(
			"\ref[item_to_update]",
			item_to_update,
			desired_icon = desired_icon,
			desired_icon_state = desired_icon_state,
			desired_layer = desired_layer,
			desired_never_blend = TRUE,
			desired_color = item_to_update.color,
			desired_pixel_x = desired_pixel_x,
			desired_pixel_y = desired_pixel_y,
			desired_transform = desired_transform
		)

	return TRUE

/obj/hud/inventory/proc/remove_from_owner()

	if(is_advanced(owner))
		var/mob/living/advanced/A = owner
		A.remove_inventory(src)

	return TRUE

/obj/hud/inventory/proc/add_to_owner(var/mob/desired_owner)

	if(desired_owner)
		owner = desired_owner

	if(owner && is_advanced(owner))
		var/mob/living/advanced/A = owner
		owner = A
		A.add_inventory(src)

	return TRUE

/obj/hud/inventory/proc/update_owner(var/mob/desired_owner) //Can also be safely used as an updater.

	if(owner == desired_owner)
		return FALSE

	remove_from_owner()
	add_to_owner(desired_owner)

	return TRUE

/obj/hud/inventory/proc/add_object(var/obj/item/I,var/messages = TRUE,var/bypass=FALSE) //Prioritize wearing it, then holding it.

	if((bypass || (!I.unremovable && I.can_be_worn())) && add_worn_object(I,messages,bypass))
		return TRUE

	if((bypass || (!I.unremovable && I.can_be_held())) && add_held_object(I,messages,bypass))
		return TRUE

	return FALSE

/obj/hud/inventory/proc/add_held_object(var/obj/item/I,var/messages = TRUE,var/bypass_checks = FALSE)

	if(!bypass_checks && !can_hold_object(I,messages))
		return FALSE

	var/atom/old_location = I.loc

	if(is_inventory(I.loc))
		var/obj/hud/inventory/I2 = I.loc
		if(I2 == src)
			return FALSE
		I2.remove_object(I,get_turf(I))

	undelete(I)

	I.force_move(src)
	I.plane = PLANE_HUD_OBJ
	held_objects += I
	I.pre_pickup(old_location,src)

	if(owner)
		I.update_owner(owner)
		if(should_add_held && is_advanced(owner))
			var/mob/living/advanced/A = owner
			A.held_objects += I
			A.update_slowdown_mul()
			update_held_icon(I)

	update_stats()
	I.on_pickup(old_location,src)
	overlays.Cut()
	update_overlays()

	return TRUE

/obj/hud/inventory/proc/add_worn_object(var/obj/item/I, var/messages = TRUE, var/bypass_checks = FALSE)

	if(!bypass_checks && !can_wear_object(I,messages))
		return FALSE

	if(!is_advanced(owner))
		return FALSE

	var/mob/living/advanced/A = owner

	/*
	for(var/obj/item/C in A.worn_objects)
		if(C.item_slot & I.item_slot && (!C.ignore_other_slots && !I.ignore_other_slots))
			if(messages)
				A.to_chat(span("notice","\The [C.name] prevents you from wearing \the [I.name]!"))
			return FALSE
	*/

	var/atom/old_location = I.loc

	if(is_inventory(I.loc))
		var/obj/hud/inventory/I2 = I.loc
		if(I2 == src)
			return FALSE
		I2.remove_object(I,owner.loc)

	undelete(I)

	I.force_move(src)
	I.plane = PLANE_HUD_OBJ
	worn_objects += I
	I.pre_pickup(old_location,src)
	if(A)
		I.update_owner(A)
		if(should_add_worn)
			A.worn_objects += I
			A.update_slowdown_mul()
			A.update_protection()
			A.update_eyes()
			A.update_clothes()
			update_worn_icon(I)

	update_stats()
	I.on_pickup(old_location,src)
	overlays.Cut()
	update_overlays()

	return TRUE

/obj/hud/inventory/proc/update_worn_icon(var/obj/item/item_to_update) //BEHOLD. SHITCODE.

	if(!is_advanced(owner))
		return FALSE

	var/mob/living/advanced/A = owner

	var/desired_icon_state

	if(item_to_update.slot_icons)
		desired_icon_state = "[item_to_update.icon_state_worn]_[src.id]"
	else
		desired_icon_state = item_to_update.icon_state_worn

	if(is_clothing(item_to_update))
		var/obj/item/clothing/C = item_to_update
		if(length(C.polymorphs))
			C.initialize_blends(desired_icon_state)

	if(is_wings(item_to_update))
		A.add_overlay_tracked("wings_behind",item_to_update,desired_layer = LAYER_MOB_WINGS_BEHIND, desired_icon=initial(item_to_update.icon), desired_icon_state = "worn_behind",desired_no_initial = item_to_update.no_initial_blend,desired_pixel_x = item_to_update.worn_pixel_x,desired_pixel_y = item_to_update.worn_pixel_y)
		A.add_overlay_tracked("wings_front",item_to_update,desired_layer = LAYER_MOB_WINGS_FRONT, desired_icon=initial(item_to_update.icon), desired_icon_state = "worn_front",desired_no_initial = item_to_update.no_initial_blend,desired_pixel_x = item_to_update.worn_pixel_x,desired_pixel_y = item_to_update.worn_pixel_y)
		A.add_overlay_tracked("wings_side",item_to_update,desired_layer = LAYER_MOB_WINGS_ADJACENT, desired_icon=initial(item_to_update.icon), desired_icon_state = "worn_adjacent",desired_no_initial = item_to_update.no_initial_blend,desired_pixel_x = item_to_update.worn_pixel_x,desired_pixel_y = item_to_update.worn_pixel_y)
	else
		A.add_overlay_tracked("\ref[item_to_update]",item_to_update,desired_layer = item_to_update.worn_layer,desired_icon=initial(item_to_update.icon),desired_icon_state = desired_icon_state,desired_no_initial = item_to_update.no_initial_blend,desired_pixel_x = item_to_update.worn_pixel_x,desired_pixel_y = item_to_update.worn_pixel_y)

	return TRUE

/obj/hud/inventory/proc/drop_worn_objects(var/turf/T,var/exclude_soulbound=FALSE)
	var/list/dropped_objects = list()
	for(var/obj/item/I in worn_objects)
		if(exclude_soulbound && I.soul_bound && I.soul_bound == owner.ckey)
			continue
		if(remove_object(I,T))
			dropped_objects += I

	return dropped_objects

/obj/hud/inventory/proc/drop_held_objects(var/turf/T,var/exclude_soulbound=FALSE)
	var/list/dropped_objects = list()
	for(var/obj/item/I in held_objects)
		if(exclude_soulbound && I.soul_bound && I.soul_bound == owner.ckey)
			continue
		if(remove_object(I,T))
			dropped_objects += I

	return dropped_objects

/obj/hud/inventory/proc/delete_held_objects()
	for(var/obj/item/I in held_objects)
		remove_object(I,owner.loc)
		qdel(I)

/obj/hud/inventory/proc/delete_worn_objects()
	for(var/obj/item/I in worn_objects)
		remove_object(I,owner.loc)
		qdel(I)

/obj/hud/inventory/proc/drop_all_objects(var/turf/T,var/exclude_soulbound=FALSE)
	var/list/dropped_objects = list()
	dropped_objects += drop_held_objects(T,exclude_soulbound)
	dropped_objects += drop_worn_objects(T,exclude_soulbound)
	return dropped_objects

/obj/hud/inventory/proc/delete_all_objects()
	delete_held_objects()
	delete_worn_objects()

/obj/hud/inventory/proc/remove_all_objects()
	for(var/obj/item/I in worn_objects)
		qdel(remove_object(I))
	for(var/obj/item/I in held_objects)
		qdel(remove_object(I))

/obj/hud/inventory/proc/remove_object(var/obj/item/I,var/turf/drop_loc,var/pixel_x_offset=0,var/pixel_y_offset=0) //Removes the object from both worn and held objects, just in case.

	var/was_worn = FALSE
	//var/was_held = FALSE

	var/was_removed = FALSE

	if(I in held_objects)
		held_objects -= I
		if(owner && is_advanced(owner) && should_add_held)
			var/mob/living/advanced/A = owner
			if(A.held_objects)
				A.held_objects -= I
		was_removed = TRUE
		//was_held = TRUE


	if(I in worn_objects)
		worn_objects -= I
		if(owner && is_advanced(owner) && should_add_worn)
			var/mob/living/advanced/A = owner
			if(A.worn_objects)
				A.worn_objects -= I
		was_removed = TRUE
		was_worn = TRUE

	if(was_removed)
		I.force_move(drop_loc ? drop_loc : get_turf(src.loc))
		I.pixel_x = pixel_x_offset
		I.pixel_y = pixel_y_offset
		I.plane = initial(I.plane)
		I.on_drop(src,drop_loc)
		overlays.Cut()
		update_overlays()
		update_stats()
		if(owner && is_advanced(owner))
			var/mob/living/advanced/A = owner
			A.remove_overlay("\ref[I]")
		if(owner)
			I.set_dir(owner.dir)
			if(is_advanced(owner))
				var/mob/living/advanced/A = owner
				A.update_slowdown_mul()
				A.update_protection()
				A.update_eyes()
				if(was_worn)
					A.update_clothes()

	return I

/obj/hud/inventory/proc/update_stats()
	total_weight = 0
	total_size = 0

	for(var/obj/item/O in held_objects)
		total_weight += O.weight
		total_size += O.size

	var/obj/item/I = get_top_object()
	if(I)
		name = I.name
	else
		name = "inventory"

	if(src.loc && is_item(src.loc))
		var/obj/item/I2 = src.loc
		I2.update_inventory()

/obj/hud/inventory/proc/can_hold_object(var/obj/item/I,var/messages = FALSE)

	if(loc && loc == I)
		return FALSE

	if(held_slots <= 0)
		return FALSE

	if(is_occupied(TRUE,TRUE))
		if(messages && src.loc)
			owner.to_chat(span("notice","\The [src.loc.name] is already occupied!"))
		return FALSE

	if(!I.can_be_held(owner,src))
		return FALSE

	if(length(item_blacklist))
		for(var/o in item_blacklist)
			if(istype(I,o))
				if(messages && src.loc)
					owner.to_chat(span("notice","\The [src.loc.name] doesn't seem suitable to hold \the [I.name]!"))
				return FALSE

	if(length(item_whitelist))
		var/whitelist_found = FALSE
		for(var/o in item_whitelist)
			if(istype(I,o))
				whitelist_found = TRUE
				break

		if(!whitelist_found)
			if(messages && src.loc)
				owner.to_chat(span("notice","\The [src.loc.name] doesn't seem suitable to hold \the [I.name]!"))
			return FALSE

	if(length(held_objects) >= held_slots)
		if(messages)
			owner.to_chat(span("notice","You don't see how you can fit any more objects inside \the [src.loc.name]."))
		return FALSE

	if(!(I.type in item_bypass) && !(src.type in I.inventory_bypass) && (max_size >= 0 || max_weight >= 0))
		if(max_size >= 0 && I.size > max_size)
			if(messages && src.loc)
				owner.to_chat(span("notice","\The [I] is too large to be put in \the [src.loc.name]."))
			return FALSE

		if(max_weight >= 0 && I.weight > max_weight)
			if(messages && src.loc)
				owner.to_chat(span("notice","\The [I] is too heavy to be put in \the [src.loc.name]."))
			return FALSE

	return TRUE

/obj/hud/inventory/proc/can_wear_object(var/obj/item/I,var/messages = FALSE)

	if(loc && loc == I)
		return FALSE

	if(worn_slots <= 0)
		return FALSE

	if(is_occupied(TRUE,TRUE))
		if(messages && src.loc)
			owner.to_chat(span("notice","\The [src.loc.name] is already occupied!"))
		return FALSE

	if(!I.can_be_held(owner,src))
		return FALSE

	if(!I.can_be_worn(owner,src))
		return FALSE

	if(worn_allow_duplicate)
		for(var/obj/item/I2 in worn_objects)
			if(I.item_slot & I.item_slot)
				if(messages) owner.to_chat(span("notice","You cannot wear \the [I.name] and \the [I2.name] at the same time!"))
				return FALSE

	if(is_clothing(I))
		var/obj/item/clothing/C = I
		if(is_advanced(owner))
			var/mob/living/advanced/A = owner
			if(C.flags_clothing)
				for(var/obj/item/organ/O in A.organs)
					if(C.flags_clothing & FLAG_CLOTHING_NOBEAST_FEET && O.flags_organ & FLAG_ORGAN_BEAST_FEET)
						if(messages)
							owner.to_chat(span("notice","Beast races cannot wear this!"))
						return FALSE
					if(C.flags_clothing & FLAG_CLOTHING_NOBEAST_HEAD && O.flags_organ & FLAG_ORGAN_BEAST_HEAD)
						if(messages)
							owner.to_chat(span("notice","Beast races cannot wear this!"))
						return FALSE

			var/list/list_to_check = I.ignore_other_slots ? src.worn_objects : A.worn_objects

			/*
			for(var/obj/item/clothing/C2 in src.worn_objects)
				if(C2.item_slot & C.item_slot)
					if(messages) owner.to_chat(span("notice","\The [C2.name] prevents you from wearing \the [C.name]!"))
					return FALSE
			*/

			for(var/obj/item/clothing/C2 in list_to_check)
				if(C2.blocks_clothing && I.item_slot && (I.item_slot & C2.blocks_clothing)) //DON'T LET YOUR EYES FOOL YOU AS THEY DID MINE.
					if(messages) owner.to_chat(span("notice","\The [C2.name] prevents you from wearing \the [C.name]!"))
					return FALSE


	if(!(I.item_slot & item_slot))
		if(messages)
			owner.to_chat(span("notice","You cannot wear \the [I] like this!"))
		return FALSE

	if(length(worn_objects) >= worn_slots)
		if(messages)
			owner.to_chat(span("notice","You cannot seem to fit this on your already existing clothing!"))
		return FALSE

	return TRUE

/obj/hud/inventory/proc/get_top_worn_object()

	if(!length(worn_objects))
		return null

	return worn_objects[length(worn_objects)]

/obj/hud/inventory/proc/get_top_held_object()

	if(!length(held_objects))
		return null

	return held_objects[length(held_objects)]