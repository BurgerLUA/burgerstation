/obj/hud/inventory/click_on_object(var/mob/caller as mob,var/atom/object,location,control,params) //The src is used on the object

	var/atom/defer_self = src.defer_click_on_object() //We could be holding an object.
	var/atom/defer_object = object.defer_click_on_object() //The object we're clicking on could be something else.

	if(caller.attack_flags & ATTACK_ALT && ismovable(defer_object))
		var/atom/movable/M = defer_object
		if(!M.anchored && M.can_rotate)
			var/rotation = -90
			if(click_flags & LEFT_HAND)
				rotation = 90



			M.set_dir(turn(M.dir,rotation))
			caller.to_chat(span("notice","You rotate \the [M.name] [rotation == -90 ? "clockwise" : "counter-clockwise"]."))
		return TRUE
	else if(caller.attack_flags & ATTACK_THROW) //Throw the object if we are telling it to throw.
		caller.face_atom(object)
		var/atom/movable/object_to_throw = src.defer_click_on_object()
		if(is_item(object_to_throw))
			var/obj/item/I = object_to_throw
			var/vel_x = object.x - caller.x
			var/vel_y = object.y - caller.y
			var/highest = max(abs(vel_x),abs(vel_y))

			if(!highest)
				I.drop_item(get_turf(caller))
				return TRUE

			vel_x *= 1/highest
			vel_y *= 1/highest

			vel_x *= 12
			vel_y *= 12

			I.drop_item(get_turf(caller))
			I.throw_self(caller,get_turf(object),text2num(params[PARAM_ICON_X]),text2num(params[PARAM_ICON_Y]),vel_x,vel_y)

		return TRUE
	else if(caller.attack_flags & ATTACK_DROP) //Drop the object if we are telling it to drop.

		if(grabbed_object)
			return release_object(caller)

		var/turf/caller_turf = get_turf(caller)
		var/turf/desired_turf = object ? get_turf(object) : null

		if(desired_turf && istype(object,/obj/structure/smooth/table) && get_dist(caller_turf,desired_turf) <= 1)
			return drop_item_from_inventory(desired_turf,text2num(params[PARAM_ICON_X])-16,text2num(params[PARAM_ICON_Y])-16)

		return drop_item_from_inventory()

	else if(grabbed_object && grabbed_object == object)
		return release_object(caller)
	else if(object && caller.attack_flags & ATTACK_GRAB && get_dist(caller,object) <= 1)
		if(isturf(object.loc))
			return grab_object(caller,object,location,control,params)
		else
			return wield_object(caller,defer_object)
	if(defer_self == grabbed_object)
		if(isturf(object) && (get_dist(caller,object) <= 1 || get_dist(object,grabbed_object) <= 1))
			var/desired_move_dir = get_dir(grabbed_object,object)
			grabbed_object.Move(get_step(grabbed_object.loc,desired_move_dir),desired_move_dir)
			if(get_dist(caller,grabbed_object) > 1)
				release_object()
		return TRUE

	if(caller.attack_flags & ATTACK_OWNER)
		if(defer_self != src)
			defer_self.click_on_object(caller,caller,location,control,params)
		else if(object != src)
			object.click_on_object(caller,caller,location,control,params)
		return TRUE

	if((caller.attack_flags & ATTACK_SELF || defer_self == defer_object) && defer_self.click_self(caller)) //Click on ourself if we're told to click on ourself.
		return TRUE

	if(is_inventory(object) && is_item(defer_self)) //We're clicking on an inventory with an item.
		var/obj/hud/inventory/object_as_inventory = object
		var/obj/item/defer_self_as_item = defer_self
		if(object_as_inventory.held_slots > 1 || object_as_inventory.worn_slots > 1) //The inventory we're clicking on can hold more than one object per slot.
			object_as_inventory.add_object(defer_self_as_item)
			return TRUE

	//Interacting wtih items in world.
	if(is_inventory(defer_self) && is_item(defer_object) && get_dist(caller,defer_object) <= 1) //We're clicking on an item with an empty hand, and it is in range.
		var/obj/item/defer_object_as_item = defer_object
		if(is_inventory(object)) //The item in question is inside another inventory.
			var/obj/hud/inventory/object_as_inventory = object
			if(!defer_object_as_item.is_container && !object_as_inventory.drag_to_take && src.add_object(defer_object_as_item))
				return TRUE
		else if (!defer_object_as_item.anchored && src.add_object(defer_object_as_item)) //Pickup the item if it isn't bolted to the ground.
			return TRUE

	if(is_item(defer_self))
		var/obj/item/defer_self_as_item = defer_self
		if(is_inventory(defer_object)) //We have an item in hand and the object we're clicking on is a blank inventory
			var/obj/hud/inventory/defer_object_as_inventory = defer_object
			if(get_dist(defer_self_as_item,defer_object_as_inventory) <= 1 && defer_object_as_inventory.add_object(defer_self_as_item))
				return TRUE

	return ..()

/obj/hud/inventory/proc/wield_object(var/mob/caller,var/obj/item/item_to_wield)

	if(!is_item(item_to_wield) || !item_to_wield.can_wield)
		return FALSE

	if(!is_inventory(item_to_wield.loc) || item_to_wield.loc == src)
		return FALSE

	var/obj/hud/inventory/holding = item_to_wield.loc
	item_to_wield.wielded = !item_to_wield.wielded
	src.parent_inventory = item_to_wield.wielded ? holding : null
	holding.child_inventory = item_to_wield.wielded ? src : null
	if(caller)
		caller.to_chat(span("notice","You [item_to_wield.wielded ? "brace" : "release"] \the [item_to_wield] with your [src.loc.name]."))
	update_sprite()
	item_to_wield.update_sprite() //This will also update the inventory.
	return TRUE

/obj/hud/inventory/dropped_on_by_object(var/atom/caller,var/atom/object)

	. = ..()

	if(!. && is_item(object) && get_dist(caller,object) <= 1)
		var/obj/item/object_as_item = object
		if(src.add_object(object_as_item))
			return TRUE

	return .

/obj/hud/inventory/get_object_to_damage_with(var/atom/attacker,var/atom/victim,params)
	return src.loc

obj/hud/inventory/proc/drop_item_from_inventory(var/turf/new_location,var/pixel_x_offset = 0,var/pixel_y_offset = 0)

	if(!length(src.held_objects))
		return FALSE

	return get_top_held_object().drop_item(new_location,pixel_x_offset,pixel_y_offset)

/obj/hud/inventory/defer_click_on_object()

	if(length(held_objects))
		return get_top_held_object()

	var/worn_length = length(worn_objects)

	if(worn_length)
		if(worn_length > 1)
			var/obj/item/I = worn_objects[worn_length]
			if(I.is_container)
				return I
			var/obj/item/I2 = worn_objects[worn_length-1]
			if(I2.is_container)
				return I2
			return I

		return get_top_worn_object()

	if(grabbed_object)
		return grabbed_object

	return src

/*
/obj/hud/inventory/get_examine_text(var/mob/examiner)
	. = ..()

	var/list/held_names = list()
	var/list/worn_names = list()

	for(var/obj/item/I in held_objects)
		held_names += I.name

	for(var/obj/item/I in worn_objects)
		worn_names += I.name

	if(length(worn_names))
		. +=

	if(length(held_names))
		. +=

	return .
*/

/obj/hud/inventory/help(var/atom/caller,var/atom/object,var/list/params=list())

	var/atom/defer_self = src.defer_click_on_object() //We could be holding an object.
	var/atom/defer_object = object.defer_click_on_object() //The object we're clicking on could be something else.

	if(defer_self == src)
		defer_self = get_object_to_damage_with(caller,object,params)

	if(defer_self && defer_object && defer_self != src && defer_self.help(caller,defer_object,params))
		return TRUE

	return ..()