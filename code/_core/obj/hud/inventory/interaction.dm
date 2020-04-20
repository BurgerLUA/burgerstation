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

	if(get_dist(defer_self,defer_object) <= 1) //We're able to interact with it.
		if(is_item(defer_self)) //We have an object in our hands.
			if(is_inventory(object)) //We're clicking on an inventory
				var/obj/hud/inventory/object_as_inventory = object
				if(object_as_inventory.can_hold_object(defer_self,FALSE)) //The inventory has space.
					object_as_inventory.add_object(defer_self) //Add the object to the inventory
					return TRUE
			if(is_item(defer_object)) //We're clicking on another object with an item.
				return ..()
		else //We don't have an object in our hands.
			if(is_item(defer_object)) //We're clicking on an item.
				var/obj/item/I = defer_object
				if(is_inventory(defer_object.loc)) //The object is in an inventory
					var/obj/hud/inventory/I2 = defer_object.loc
					if(!I.is_container && I2.click_flags) //The object we're clicking on is actually in our other hand and it's not a container
						return ..()
					if(I2.drag_to_take || I.is_container) //The object that we're clicking on needs to be dragged in order to be taken, or it's a container.
						I.click_self(caller)
						return TRUE
				src.add_object(defer_object)
				return TRUE

	return ..()

/obj/hud/inventory/drop_on_object(var/atom/caller,var/atom/object,location,control,params) //Src is dragged to object

	if(is_inventory(object))
		var/obj/hud/inventory/object_as_inventory = object
		var/obj/item/I = src.get_top_object()
		if(I)
			object_as_inventory.add_object(I)
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

/obj/hud/inventory/dropped_on_by_object(var/atom/caller,var/atom/object,location,control,params) //Object dropped on src

	if(is_item(object) && get_dist(caller,object) <= 1) //Put the itme in the inventory slot.
		var/obj/item/object_as_item = object
		var/atom/defer_self = src.defer_click_on_object()
		if(is_item(defer_self))
			var/obj/item/self_as_item = defer_self
			self_as_item.dropped_on_by_object(caller,object_as_item,location,control,params)
			return TRUE
		if(src.add_object(object_as_item))
			return TRUE

	return ..()

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