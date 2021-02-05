//Inventory system. Basically anything that can hold an object needs an inventory.

/obj/hud/inventory/
	name = "Inventory Holder"
	desc = "Inventory"
	var/id = "BADINVENTORY"

	alpha = 225

	//icon = 'icons/invisible.dmi'
	//icon_state = "0"

	icon = 'icons/hud/hud.dmi'
	icon_state = "square"

	plane = PLANE_HUD
	layer = -1 //Needs to be low.

	value = 0

	var/atom/movable/grabbed_object

	var/worn = FALSE //Set to TRUE if it's a worn object.

	var/max_slots = 1

	var/max_size = -1 //Maximum amount of size this object can hold. -1 basically means it can't hold anything.
	var/total_size = 0 //Var storage value that is updated every time an item is changed.

	var/should_add_to_advanced = TRUE //Set to false if it's some sort of special object that doesn't count towards the owner's inventory.

	var/worn_allow_duplicate = FALSE //Can you wear more than one item of the same slot at once?

	var/item_slot = SLOT_NONE //Items that can be worn in this slot. Applies to clothing only.

	var/priority = 0 //The priority level of the inventory. Item transfer favors inventories with higher values.

	var/inventory_temperature_mod = 0 //How much to add or remove from the ambient temperature for calculating reagent temperature.
	var/inventory_temperature_mod_mod = 0.5 //The temperature mod of the inventory object. Higher values means faster temperature transition. Lower means slower. Zero means don't change from inventory.

	var/list/obj/item/item_blacklist = list() //Items that can't go in this invetory.
	var/list/obj/item/item_whitelist = list() //Items that can only go in this inventory.
	var/list/obj/item/item_bypass = list() //Items that bypass any size requirements.

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

	var/drop_on_death = FALSE //Set to true if this inventory should drop all its contents when the owner dies.

	var/allow_quick_equip = TRUE

	interaction_flags = FLAG_INTERACTION_LIVING | FLAG_INTERACTION_NO_DISTANCE | FLAG_INTERACTION_NO_DISTANCE

/obj/hud/inventory/proc/is_occupied(var/ignore_contents=FALSE)

	if(!ignore_contents && length(contents))
		return TRUE

	if(grabbed_object)
		return TRUE

	if(parent_inventory)
		return TRUE

	if(child_inventory)
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

	owner = null

	parent_inventory = null
	child_inventory = null
	grabbed_object = null

	return ..()

/obj/hud/inventory/proc/show(var/should_show,var/speed)
	if(should_show)
		animate(src,alpha=initial(alpha),time=SECONDS_TO_DECISECONDS(speed))
		src.mouse_opacity = 2
	else
		animate(src,alpha=0,time=SECONDS_TO_DECISECONDS(speed))
		src.mouse_opacity = 0

/obj/hud/inventory/New(var/desired_loc)
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

	if(parent_inventory)
		color = "#ff0000"
		add_overlay(parent_inventory.overlays)
	else if(grabbed_object)
		color = "#ffff00"
		var/image/I = new/image(initial(icon),"grab")
		add_overlay(I)
	else
		color = initial(color)

	return .

/obj/hud/inventory/proc/update_held_icon(var/obj/item/item_to_update)

	//OVERLAY BUG, NOT THIS.
	if(!owner || !is_advanced(owner) || !item_to_update)
		return FALSE

	if(!item_to_update.dan_mode && !item_to_update.enable_held_icon_states)
		return FALSE

	var/mob/living/advanced/A = owner

	var/icon/desired_icon = initial(item_to_update.icon)
	var/desired_icon_state = null
	var/desired_pixel_x = 0
	var/desired_pixel_y = 0
	var/desired_layer = LAYER_MOB_HELD
	var/matrix/desired_transform = matrix()

	if(item_to_update.dan_mode && (id == BODY_HAND_LEFT || id == BODY_HAND_RIGHT || id == BODY_TORSO_OB) )
		if(id == BODY_TORSO_OB)
			desired_icon_state = item_to_update.dan_icon_state_back
		else
			desired_icon_state = item_to_update.wielded ? item_to_update.dan_icon_state_wielded : item_to_update.dan_icon_state
		switch(get_true_4dir(owner.dir))
			if(NORTH)
				if(id == BODY_TORSO_OB)
					desired_layer = item_to_update.dan_layer_above
				else
					desired_layer = item_to_update.dan_layer_below
					if(item_to_update.wielded)
						if(click_flags & RIGHT_HAND)
							desired_transform.Scale(-1,1)
					else
						if(click_flags & RIGHT_HAND)
							desired_pixel_x = item_to_update.dan_offset_pixel_x[1]
							desired_pixel_y = item_to_update.dan_offset_pixel_y[1]
							desired_transform.Scale(-1,1)
						else
							desired_pixel_x = -item_to_update.dan_offset_pixel_x[1]
							desired_pixel_y = -item_to_update.dan_offset_pixel_y[1]

			if(EAST)
				if(id == BODY_TORSO_OB)
					desired_layer = item_to_update.dan_layer_below
					desired_transform.Scale(-0.5,1)
					desired_pixel_x = -4
				else
					if(item_to_update.wielded)
						desired_layer = item_to_update.dan_layer_above
						desired_pixel_x = 4
					else
						if(click_flags & RIGHT_HAND)
							desired_pixel_x = item_to_update.dan_offset_pixel_x[2]
							desired_pixel_y = item_to_update.dan_offset_pixel_y[2]
							desired_layer = item_to_update.dan_layer_above
						else
							desired_pixel_x = -item_to_update.dan_offset_pixel_x[2] + 4
							desired_pixel_y = -item_to_update.dan_offset_pixel_y[2]
							desired_layer = item_to_update.dan_layer_below
						desired_transform.Scale(-1,1)
			if(SOUTH)
				if(id == BODY_TORSO_OB)
					desired_layer = item_to_update.dan_layer_below
				else
					desired_layer = item_to_update.dan_layer_above
					if(item_to_update.wielded)
						if(click_flags & LEFT_HAND)
							desired_transform.Scale(-1,1)
					else
						if(click_flags & RIGHT_HAND)
							desired_pixel_x = item_to_update.dan_offset_pixel_x[3]
							desired_pixel_y = item_to_update.dan_offset_pixel_y[3]
						else
							desired_pixel_x = -item_to_update.dan_offset_pixel_x[3]
							desired_pixel_y = -item_to_update.dan_offset_pixel_y[3]
							desired_transform.Scale(-1,1)
			if(WEST)
				if(id == BODY_TORSO_OB)
					desired_layer = item_to_update.dan_layer_below
					desired_transform.Scale(0.5,1)
					desired_pixel_x = 4
				else
					if(item_to_update.wielded)
						desired_layer = item_to_update.dan_layer_above
						desired_transform.Scale(-1,1)
						desired_pixel_x = -4
					else
						if(click_flags & RIGHT_HAND)
							desired_layer = item_to_update.dan_layer_below
							desired_pixel_x = item_to_update.dan_offset_pixel_x[4] - 4
							desired_pixel_y = item_to_update.dan_offset_pixel_y[4]
						else
							desired_layer = item_to_update.dan_layer_above
							desired_pixel_x = -item_to_update.dan_offset_pixel_x[4]
							desired_pixel_y = -item_to_update.dan_offset_pixel_y[4]

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
			var/icon/I2 = new /icon(desired_icon,"[desired_icon_state]_[polymorph_name]")
			I2.Blend(polymorph_color,ICON_MULTIPLY)
			I.Blend(I2,ICON_OVERLAY)
		desired_icon_state = null
		desired_icon = I

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

/obj/hud/inventory/proc/add_object(var/obj/item/I,var/messages = TRUE,var/bypass_checks = FALSE,var/silent=FALSE)

	if(!I)
		return FALSE

	if(bypass_checks && max_slots <= 0)
		return FALSE

	if(!bypass_checks && !can_slot_object(I,messages))
		return FALSE

	if(I.qdeleting)
		I.drop_item(null)
		return FALSE


	var/atom/old_location = I.loc

	I.drop_item(src,silent=silent)
	I.pre_pickup(old_location,src)

	if(owner)
		I.update_owner(owner)
		if(is_advanced(owner) && should_add_to_advanced)
			var/mob/living/advanced/A = owner
			if(worn)
				A.worn_objects += I
				update_worn_icon(I)
			else
				A.held_objects += I
				update_held_icon(I)
			A.update_items(should_update_eyes = worn, should_update_protection = worn, should_update_clothes = worn)


	update_stats()
	I.on_pickup(old_location,src)
	vis_contents |= I

	if(I.loc != src) //Something went wrong.
		owner.to_chat(span("danger","Inventory glitch detected. Please report this bug on discord. Error Code: 01"))
		I.drop_item(get_turf(src))

	return TRUE

/obj/hud/inventory/proc/update_worn_icon(var/obj/item/item_to_update)

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


/obj/hud/inventory/proc/drop_objects(var/turf/T,var/exclude_soulbound=FALSE)
	var/list/dropped_objects = list()
	for(var/k in contents)
		var/obj/item/I = k
		if(exclude_soulbound && I.soul_bound && I.soul_bound == owner.ckey)
			continue
		if(remove_object(I,T))
			dropped_objects += I

	return dropped_objects

/obj/hud/inventory/proc/delete_objects()
	for(var/k in contents)
		var/obj/item/I = k
		I.delete_on_drop = TRUE
		remove_object(I,owner.loc)

/obj/hud/inventory/proc/remove_object(var/obj/item/I,var/turf/drop_loc,var/pixel_x_offset=0,var/pixel_y_offset=0,var/silent=FALSE) //Removes the object from both worn and held objects, just in case.

	I.force_move(drop_loc ? drop_loc : get_turf(src.loc)) //THIS SHOULD NOT BE ON DROP
	I.pixel_x = pixel_x_offset
	I.pixel_y = pixel_y_offset

	update_stats()

	if(owner && is_advanced(owner))
		var/mob/living/advanced/A = owner
		if(worn && is_wings(I))
			A.remove_overlay("wings_behind")
			A.remove_overlay("wings_front")
			A.remove_overlay("wings_side")
		else
			A.remove_overlay("\ref[I]")

	if(owner)
		I.set_dir(owner.dir)
		if(is_advanced(owner))
			var/mob/living/advanced/A = owner
			if(worn)
				A.worn_objects -= I
			else
				A.held_objects -= I
			A.update_items(should_update_eyes = worn, should_update_protection = worn, should_update_clothes = worn)

	vis_contents -= I

	I.on_drop(src,drop_loc,silent)

	return I

/obj/hud/inventory/proc/update_stats()

	total_size = 0

	for(var/k in contents)
		var/obj/item/O = k
		total_size += O.size

	var/obj/item/I = get_top_object()
	if(I)
		name = I.name
	else
		name = initial(name)

	if(is_item(src.loc))
		var/obj/item/I2 = src.loc
		I2.update_inventory()

/obj/hud/inventory/proc/can_unslot_object(var/obj/item/I,var/messages = FALSE)

	if(!I.item_slot)
		return FALSE

	if(!is_advanced(owner))
		return TRUE

	var/mob/living/advanced/A = owner
	for(var/obj/item/clothing/C in A.worn_objects)
		if(C == I)
			continue
		if(C.ignore_other_slots)
			continue
		if(C.loc != I.loc && C.blocks_clothing && (I.item_slot & C.blocks_clothing))
			if(messages) owner.to_chat(span("warning","\The [C.name] prevents you from removing \the [I.name]!"))
			return FALSE

	return TRUE

/obj/hud/inventory/proc/can_slot_object(var/obj/item/I,var/messages = FALSE)

	if(loc && loc == I)
		return FALSE

	if(max_slots <= 0)
		log_error("Warning: [src.get_debug_name()] had no slots!")
		return FALSE

	if(length(contents) >= max_slots)
		/* TODO: REMAKE
		if(messages)
			owner.to_chat(span("notice","You cannot seem to fit \the [I.name] on your already existing clothing!"))
		*/
		return FALSE

	if(!I.can_be_held(owner,src,messages) || (worn && !I.can_be_worn(owner,src,messages)))
		return FALSE

	if(is_occupied(TRUE,TRUE))
		if(messages && src.loc)
			owner.to_chat(span("warning","\The [src.loc.name] is already occupied!"))
		return FALSE

	if(is_inventory(I.loc))
		var/obj/hud/inventory/INV = I.loc
		if(INV.worn && !INV.can_unslot_object(I,messages))
			return FALSE

	if(length(item_blacklist))
		for(var/o in item_blacklist)
			if(istype(I,o))
				if(messages && src.loc)
					owner.to_chat(span("warning","\The [src.loc.name] doesn't seem suitable to hold \the [I.name]!"))
				return FALSE

	if(length(item_whitelist))
		var/whitelist_found = FALSE
		for(var/o in item_whitelist)
			if(istype(I,o))
				whitelist_found = TRUE
				break

		if(!whitelist_found)
			if(messages && src.loc)
				owner.to_chat(span("warning","\The [src.loc.name] doesn't seem suitable to hold \the [I.name]!"))
			return FALSE

	if(worn)
		if(worn_allow_duplicate)
			for(var/k in contents)
				var/obj/item/I2 = k
				if(I.item_slot & I.item_slot)
					if(messages) owner.to_chat(span("warning","You cannot wear \the [I.name] and \the [I2.name] at the same time!"))
					return FALSE

		if(is_clothing(I))
			var/obj/item/clothing/C = I
			if(is_advanced(owner))
				var/mob/living/advanced/A = owner
				if(C.flags_clothing)
					for(var/k in A.organs)
						var/obj/item/organ/O = k
						if(C.flags_clothing & FLAG_CLOTHING_NOBEAST_FEET && O.flags_organ & FLAG_ORGAN_BEAST_FEET)
							if(messages)
								owner.to_chat(span("warning","You cannot seem to fit \the [I.name] on your non-human feet..."))
							return FALSE
						if(C.flags_clothing & FLAG_CLOTHING_NOBEAST_HEAD && O.flags_organ & FLAG_ORGAN_BEAST_HEAD)
							if(messages)
								owner.to_chat(span("warning","You cannot seem to fit \the [I.name] on your non-human head..."))
							return FALSE
				if(C.item_slot)
					var/list/list_to_check = C.ignore_other_slots ? src.contents : A.worn_objects
					for(var/obj/item/clothing/C2 in list_to_check)
						if(C2.blocks_clothing && (C.item_slot & C2.blocks_clothing)) //DON'T LET YOUR EYES FOOL YOU AS THEY DID MINE.
							if(messages) owner.to_chat(span("notice","\The [C2.name] prevents you from wearing \the [C.name]!"))
							return FALSE


		if(!(I.item_slot & item_slot))
			if(messages)
				owner.to_chat(span("notice","You cannot wear \the [I.name] like this!"))
			return FALSE

	if(!(I.type in item_bypass) && !(src.type in I.inventory_bypass) && max_size >= 0)
		if(max_size >= 0 && I.size > max_size)
			if(messages && src.loc)
				owner.to_chat(span("warning","\The [I] is too large to be put in \the [src.loc.name]."))
			return FALSE

	return TRUE

/atom/proc/get_top_object()

	var/content_length = length(contents)

	if(!content_length)
		return null

	return contents[content_length]
