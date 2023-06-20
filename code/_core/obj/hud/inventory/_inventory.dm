//Inventory system. Basically anything that can hold an object needs an inventory.

/obj/hud/inventory/
	name = "Inventory Holder"
	desc = "Inventory"
	var/id = "BADINVENTORY"

	alpha = 225

	icon = 'icons/hud/hud.dmi'
	icon_state = "square"

	var/atom/movable/grabbed_object

	var/worn = FALSE //Set to TRUE if it's a worn object.

	var/max_slots = 1

	var/max_size = -1 //Maximum amount of size this object can hold. -1 basically means it can't hold anything.
	var/total_size = 0 //Var storage value that is updated every time an item is changed.

	var/should_add_to_advanced = TRUE //Set to false if it's some sort of special object that doesn't count towards the owner's inventory.

	var/worn_allow_duplicate = FALSE //Can you wear more than one item of the same slot at once?

	var/item_slot = SLOT_NONE //Items that can be worn in this slot. Applies to non-held slots only. See _defines/item.dm for info.
	var/item_slot_mod = SLOT_MOD_NONE //The slot mod. See _defines/item.dm for info.

	var/priority = 0 //The priority level of the inventory. Item transfer favors inventories with higher values.

	var/inventory_temperature = 0 //How much to add or remove from the ambient temperature for calculating reagent temperature.
	var/inventory_temperature_mod = 1 //The end multiplier for how fast temperature changes should be handled.

	var/list/obj/item/item_blacklist = list() //Items that can't go in this invetory.
	var/list/obj/item/item_whitelist = list() //Items that can only go in this inventory.
	var/list/obj/item/item_bypass = list() //Items that bypass any size requirements.

	var/click_flags

	flags_hud = FLAG_HUD_INVENTORY

	var/should_draw = TRUE //Should the item's held icon be displayed?

	var/drag_to_take = TRUE //You must click and drag to take the object inside.

	var/obj/hud/inventory/parent_inventory //Basically one massive defer to this inventory.
	var/obj/hud/inventory/child_inventory

	mouse_over_pointer = MOUSE_ACTIVE_POINTER
	mouse_drag_pointer = MOUSE_ACTIVE_POINTER
	mouse_drop_pointer = MOUSE_ACTIVE_POINTER
	mouse_drop_zone = 1

	mouse_opacity = 1

	var/essential = FALSE //Should this be drawn when the inventory is hidden?
	var/is_container = FALSE //Set to true if it uses the container inventory system.

	var/x_offset = 0
	var/y_offset = 0

	var/draw_extra = FALSE

	var/allow_quick_equip = TRUE

	interaction_flags = FLAG_INTERACTION_LIVING | FLAG_INTERACTION_NO_DISTANCE | FLAG_INTERACTION_CLICK

	var/inventory_category = "none"

	var/obj/hud/button/close_inventory/assoc_button

	var/grab_level = 1 //Passive grab
	var/grab_time //Cooldown on upgrading grab

	var/ultra_persistant = FALSE //Saves even after death (but of course, removes the previous instance if unrevivable.)

	var/light_mod = 0 //Power multiplier for lights for being in this inventory. Worn inventories will always have this at 1.

	var/advanced_layering = FALSE //Set to TRUE to enable advanced layering, where the layer of clothing is based on the layer below.

	layer = 0 //has to be this way

	var/busy = FALSE

/obj/hud/inventory/MouseEntered(location,control,params)

	. = ..()

	var/atom/A = get_top_object()
	if(A)
		A.MouseEntered(location,control,params)

/obj/hud/inventory/MouseExited(location,control,params)

	. = ..()

	var/atom/A = get_top_object()
	if(A)
		A.MouseExited(location,control,params)


/obj/hud/inventory/PreDestroy()

	if(grabbed_object)
		release_object()
		grabbed_object = null //Just in case.

	show(FALSE,0)

	. = ..()

	update_owner(null) //This proc is custom to /obj/hud/inventory so it won't cause issues.

/obj/hud/inventory/Destroy()
	parent_inventory = null
	child_inventory = null
	. = ..()


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

/obj/hud/inventory/proc/show(var/should_show,var/speed=SECONDS_TO_DECISECONDS(1))
	if(should_show)
		animate(src,alpha=initial(alpha),time=speed)
		mouse_opacity = initial(mouse_opacity)
	else
		animate(src,alpha=0,time=speed)
		src.mouse_opacity = 0

/obj/hud/inventory/Finalize()
	. = ..()
	update_sprite()

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
	else
		color = initial(color)

	if(grabbed_object)
		if(grab_level == 1) //Passive grab
			var/image/I = new/image(initial(icon),"grab")
			I.pixel_x = x_offset
			add_overlay(I)
		else if(grab_level == 2) //Agressive grab
			var/image/I = new/image(initial(icon),"grab_aggressive")
			I.pixel_x = x_offset
			add_overlay(I)


/obj/hud/inventory/proc/update_held_icon(var/obj/item/item_to_update)

	//OVERLAY BUG, NOT THIS.
	if(!owner || !is_advanced(owner) || !item_to_update)
		return FALSE

	if(!item_to_update.dan_mode && !item_to_update.enable_held_icon_states)
		return FALSE

	var/mob/living/advanced/A = owner

	var/icon/desired_icon = initial(item_to_update.icon)
	var/desired_icon_state = null
	var/desired_pixel_x = item_to_update.held_pixel_x
	var/desired_pixel_y = item_to_update.held_pixel_y
	var/desired_layer = LAYER_MOB_HELD
	var/matrix/desired_transform = get_base_transform()

	if(item_to_update.dan_mode && (id == BODY_HAND_LEFT_HELD || id == BODY_HAND_RIGHT_HELD || id == BODY_TORSO_OB) )
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

	else if(id == BODY_HAND_LEFT_HELD)
		desired_icon_state = item_to_update.icon_state_held_left
	else if(id == BODY_HAND_RIGHT_HELD)
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

/obj/hud/inventory/update_owner(var/mob/desired_owner) //Can also be safely used as an updater.

	if(owner == desired_owner)
		return FALSE

	if(is_advanced(owner))
		var/mob/living/advanced/A = owner
		A.remove_inventory(src)

	owner = desired_owner
	if(is_advanced(desired_owner))
		var/mob/living/advanced/A = owner
		A.add_inventory(src)

	return TRUE

/obj/hud/inventory/proc/add_object(var/obj/item/I,var/messages = TRUE,var/bypass_checks = FALSE,var/silent=FALSE,var/debug=FALSE)

	if(!I)
		if(debug) log_error("add_object() fail: Item didn't exist!")
		return FALSE

	if(I.qdeleting)
		if(debug) log_error("add_object() fail: Item was qdeleting!")
		I.drop_item(null)
		return FALSE

	if(!bypass_checks && busy)
		if(debug) log_error("add_object() fail: Was busy!")
		return FALSE

	if(!bypass_checks && !can_slot_object(I,messages))
		if(debug) log_error("add_object() fail: Could not slot object!")
		return FALSE

	var/atom/old_location = I.loc

	if(!I.drop_item(src,silent=silent))
		if(debug) log_error("add_object() fail: Object couldn't be moved!")
		return FALSE

	if(I.loc != src) //Something went wrong.
		if(!owner)
			usr.to_chat(span("danger","Inventory glitch detected. Please report this bug on discord. Error Code: 01"))
		else
			owner.to_chat(span("danger","Inventory glitch detected. Please report this bug on discord. Error Code: 02"))
		I.drop_item(get_turf(src))
		if(debug) log_error("add_object() fail: Inventory glitch!")
		return FALSE

	if(owner)
		I.update_owner(owner)
		if(is_advanced(owner) && should_add_to_advanced)
			var/mob/living/advanced/A = owner
			if(worn)
				A.worn_objects += I
				src.update_worn_icon(I)
			else
				A.held_objects += I
				src.update_held_icon(I)
			A.queue_update_items = TRUE

	I.pre_equip(old_location,src)

	I.pixel_x = initial(I.pixel_x) + x_offset
	I.pixel_y = initial(I.pixel_y) + y_offset

	vis_contents += I
	I.layer = LAYER_BASE + length(vis_contents)

	I.on_equip(old_location,silent)

	if(is_item(src.loc))
		var/obj/item/IL = src.loc
		IL.update_inventory()

	if(debug) log_error("add_object() success!")

	update_stats()

	return TRUE

/obj/hud/inventory/proc/update_worn_icon(var/obj/item/item_to_update)

	var/mob/living/advanced/A = owner

	var/desired_icon_state

	if(item_to_update.slot_icons)
		desired_icon_state = "[item_to_update.icon_state_worn]_[src.id]"
	else
		desired_icon_state = item_to_update.icon_state_worn

	item_to_update.initialize_worn_blends(desired_icon_state)

	item_to_update.handle_overlays(
		A,
		add=TRUE,
		worn=TRUE,
		icon_state_override=desired_icon_state
	)

	return TRUE


/obj/hud/inventory/proc/drop_objects(var/turf/T,var/disarm=FALSE)

	. = list()

	for(var/k in contents)
		var/obj/item/I = k
		if(disarm && I.size <= SIZE_2)
			continue
		if(remove_object(I,T))
			. += I

/obj/hud/inventory/proc/delete_objects()
	var/turf/T = get_turf(src)
	for(var/k in contents)
		var/obj/item/I = k
		I.delete_on_drop = TRUE
		remove_object(I,T)

/obj/hud/inventory/proc/remove_object(var/obj/item/I,var/turf/drop_loc,var/pixel_x_offset=0,var/pixel_y_offset=0,var/silent=FALSE) //Removes the object from both worn and held objects, just in case.

	if(!I)
		log_error("Error: Tried to remove null object from an inventory!")
		return null

	I.force_move(drop_loc ? drop_loc : get_turf(src.loc))
	I.pixel_x = initial(I.pixel_x) + pixel_x_offset
	I.pixel_y = initial(I.pixel_y) + pixel_y_offset

	if(owner && !owner.qdeleting)
		if(is_advanced(owner))
			var/mob/living/advanced/A = owner
			I.handle_overlays(A,remove=TRUE)
			if(worn)
				A.worn_objects -= I
			else
				A.held_objects -= I
			A.queue_update_items = TRUE
		I.set_dir(owner.dir)

	vis_contents -= I

	I.on_unequip(src,silent)

	if(is_item(src.loc))
		var/obj/item/IL = src.loc
		IL.update_inventory()

	if(is_turf(drop_loc))
		I.layer = initial(I.layer) + clamp(I.value / 10000,0,0.999)

	update_stats()

	return I

/obj/hud/inventory/proc/update_stats()

	total_size = 0

	for(var/k in contents)
		var/obj/item/O = k
		total_size += O.size

	var/obj/item/I = get_top_object()
	if(I)
		name = I.name
		desc_extended = I.desc_extended
	else
		name = initial(name)
		desc_extended = initial(desc_extended)

	tooltip_text = initial(tooltip_text)
	if(!tooltip_text)
		tooltip_text = generate_tooltip_text()

	HOOK_CALL("update_stats")

/obj/hud/inventory/proc/can_unslot_object(var/obj/item/I,var/messages = FALSE)
	return TRUE

	/* Slot overhaul, might need this.
	if(!I.item_slot || !(I.item_slot & item_slot))
		return TRUE

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
	*/

/obj/hud/inventory/act_emp(var/atom/owner,var/atom/source,var/atom/epicenter,var/magnitude,var/desired_loyalty_tag)

	. = ..()

	for(var/k in contents)
		var/atom/movable/M = k
		if(M.act_emp(owner,source,epicenter,magnitude,desired_loyalty_tag))
			. = TRUE

/obj/hud/inventory/proc/can_slot_object(var/obj/item/I,var/messages = FALSE,var/bypass=FALSE)

	if(loc && loc == I)
		return FALSE

	if(length(contents) >= max_slots)
		/* TODO: REMAKE
		if(messages)
			owner.to_chat(span("notice","You cannot seem to fit \the [I.name] on your already existing clothing!"))
		*/
		return FALSE

	if(is_occupied(TRUE,TRUE))
		if(messages && src.loc)
			owner.to_chat(span("warning","\The [src.loc.name] is already occupied!"))
		return FALSE

	if(bypass)
		return TRUE

	if(!I.can_be_held(owner,src,messages) || (worn && !I.can_be_worn(owner,src,messages)))
		return FALSE

	if(is_inventory(I.loc))
		var/obj/hud/inventory/INV = I.loc
		if(INV.worn && !INV.can_unslot_object(I,messages))
			return FALSE

	if(length(item_blacklist))
		for(var/o in item_blacklist)
			if(!istype(I,o))
				continue
			if(messages && src.loc)
				owner.to_chat(span("warning","\The [src.loc.name] doesn't seem suitable to hold \the [I.name]!"))
			return FALSE

	if(length(item_whitelist))
		var/whitelist_found = FALSE
		for(var/o in item_whitelist)
			if(!istype(I,o))
				continue
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


		if(is_advanced(owner))
			var/mob/living/advanced/A = owner
			if(I.item_slot && I.item_slot_layer)
				for(var/k in src.contents)
					var/obj/item/clothing/existing_clothing = k
					if(!is_clothing(existing_clothing))
						continue
					if(existing_clothing.item_slot_layer < I.item_slot_layer)
						continue
					if(messages) owner.to_chat(span("warning","\The [existing_clothing.name] prevents you from wearing \the [I.name]!"))
					return FALSE
			if(is_clothing(I))
				var/obj/item/clothing/C = I
				if(C.flags_clothing)
					for(var/k in A.organs)
						var/obj/item/organ/O = k
						if(C.flags_clothing & FLAG_CLOTHING_NOBEAST_FEET && O.flags_organ & FLAG_ORGAN_BEAST_FEET)
							if(messages) owner.to_chat(span("warning","You cannot seem to fit \the [I.name] on your non-humanoid feet..."))
							return FALSE
						if(C.flags_clothing & FLAG_CLOTHING_NOBEAST_HEAD && O.flags_organ & FLAG_ORGAN_BEAST_HEAD)
							if(messages) owner.to_chat(span("warning","You cannot seem to fit \the [I.name] on your non-humanoid head..."))
							return FALSE

		if(!(I.item_slot & item_slot))
			if(messages)
				owner.to_chat(span("notice","\The [I.name] doesn't fit on \the [src.loc.name]!"))
			return FALSE

		if(item_slot_mod & (SLOT_MOD_LEFT | SLOT_MOD_RIGHT) && !((I.item_slot_mod & SLOT_MOD_RIGHT) && (I.item_slot_mod & SLOT_MOD_LEFT)))
			var/is_right_hand = item_slot_mod & SLOT_MOD_RIGHT
			var/is_right_item = I.item_slot_mod & SLOT_MOD_RIGHT
			if(is_right_hand != is_right_item)
				if(messages)
					owner.to_chat(span("notice","\The [I.name] doesn't fit on \the [src.loc.name]!"))
				return FALSE

	if(max_size >= 0 && I.size > max_size && !(I.type in item_bypass) && !(src.type in I.inventory_bypass))
		if(messages && src.loc)
			owner.to_chat(span("warning","\The [I] is too large to be put in \the [src.loc.name]."))
		return FALSE

	return TRUE

/atom/proc/get_top_object()

	var/content_length = length(contents)

	if(!content_length)
		return null

	return contents[content_length]
