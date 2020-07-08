/obj/hud/inventory/click_on_object(var/mob/caller as mob,var/atom/object,location,control,params) //The src is used on the object

	if(is_living(caller))
		var/mob/living/L = caller
		if(L.dead && !(object.interaction_flags & FLAG_INTERACTION_DEAD))
			L.to_chat(span("warning","You're dead!"))
			return FALSE

	var/atom/defer_self = src.defer_click_on_object(location,control,params) //We could be holding an object.
	var/atom/defer_object = object.defer_click_on_object(location,control,params) //The object we're clicking on could be something else.

	if(object && caller.attack_flags & ATTACK_GRAB && get_dist(caller,object) <= 1)
		if(isturf(object.loc))
			if(is_living(object))
				var/mob/living/L = object
				if(!L.add_status_effect(GRAB, source = caller))
					caller.to_chat(span("warning","\The [object.name] is too strong to be grabbed!"))
					return TRUE
			grab_object(caller,object,location,control,params)
			return TRUE
		else
			return wield_object(caller,defer_object)

	if(parent_inventory)
		return TRUE

	if(caller.attack_flags & ATTACK_ALT && ismovable(defer_object))
		var/atom/movable/M = defer_object
		if(!M.anchored && M.can_rotate)
			var/rotation = -90
			if(click_flags & LEFT_HAND)
				rotation = 90
			M.set_dir(turn(M.dir,rotation))
			caller.to_chat(span("notice","You rotate \the [M.name] [rotation == -90 ? "clockwise" : "counter-clockwise"]."))
		return TRUE

	else if(caller.attack_flags & ATTACK_THROW && is_living(caller)) //Throw the object if we are telling it to throw.
		var/mob/living/L = caller
		object = object.defer_click_on_object(location,control,params)
		caller.face_atom(object)
		var/atom/movable/object_to_throw = src.defer_click_on_object(location,control,params)
		if(is_item(object_to_throw))
			var/obj/item/I = object_to_throw
			if(I.additional_clothing_parent)
				caller.to_chat(span("warning","You can't throw this!"))
				return TRUE
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
			I.throw_self(caller,get_turf(object),text2num(params[PARAM_ICON_X]),text2num(params[PARAM_ICON_Y]),vel_x,vel_y,steps_allowed = VIEW_RANGE,lifetime = 30,desired_iff = L.iff_tag)
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

	if(defer_self == grabbed_object)
		if(isturf(object) && (get_dist(caller,object) <= 1 || get_dist(object,grabbed_object) <= 1))
			var/desired_move_dir = get_dir(grabbed_object,object)
			grabbed_object.Move(get_step(grabbed_object.loc,desired_move_dir),desired_move_dir)
		return TRUE

	if(caller.attack_flags & ATTACK_OWNER)
		if(defer_self != src)
			defer_self.click_on_object(caller,caller,location,control,params)
		else if(object != src)
			object.click_on_object(caller,caller,location,control,params)
		return TRUE

	if((caller.attack_flags & ATTACK_SELF || defer_self == defer_object) && defer_self.click_self(caller)) //Click on ourself if we're told to click on ourself.
		return TRUE

	if(get_dist(defer_self,defer_object) <= 1) //We're able to interact with the item.
		if(is_item(defer_self)) //We have an object in our hands.
			if(is_inventory(object)) //We're clicking on an inventory. It may or may not have an object.
				var/obj/hud/inventory/object_as_inventory = object
				if(object_as_inventory.can_wear_object(defer_self,FALSE))
					object_as_inventory.add_worn_object(defer_self) //Add the object to the inventory
					return TRUE
				if(object_as_inventory.can_hold_object(defer_self,FALSE)) //The inventory has space.
					object_as_inventory.add_held_object(defer_self) //Add the object to the inventory
					return TRUE
		else if(is_item(defer_object)) //We don't have an object in our hands and we're clicking on an item.
			var/obj/item/I = defer_object
			if(is_inventory(defer_object.loc)) //The object is in an inventory
				var/obj/hud/inventory/I2 = defer_object.loc
				if(I.is_container) //The object that we're clicking on is a container and it should be opened instead.
					I.click_self(caller)
					return TRUE
				if(!I2.click_flags && !I2.drag_to_take)
					src.add_object(defer_object)
					return TRUE
			else
				src.add_object(defer_object)
				return TRUE

	//Stolen from /atom/proc/click_on_object
	if(src != defer_self && defer_self.click_on_object(caller,object,location,control,params))
		return TRUE

	if(object.clicked_on_by_object(caller,src,location,control,params))
		return TRUE

	if(is_organ(src.loc))
		var/obj/item/organ/O = src.loc
		return O.attack(caller,object,params)

	return FALSE

/obj/hud/inventory/drop_on_object(var/atom/caller,var/atom/object,location,control,params) //Src is dragged to object

	if(is_inventory(object))
		var/obj/hud/inventory/object_as_inventory = object
		var/obj/item/I = src.get_top_object()
		if(I && I.can_be_dragged(caller) && get_dist(src,object) <= 1)
			object_as_inventory.add_object(I)
		return TRUE

	return ..()




/obj/hud/inventory/proc/wield_object(var/mob/caller,var/obj/item/item_to_wield)

	if(!is_item(item_to_wield) || !item_to_wield.can_wield)
		return FALSE

	if(!is_inventory(item_to_wield.loc) || item_to_wield.loc == src)
		return FALSE

	var/obj/hud/inventory/holding = item_to_wield.loc

	if(!(holding.click_flags & (LEFT_HAND | RIGHT_HAND)))
		return FALSE

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
		var/atom/defer_self = src.defer_click_on_object(location,control,params)
		if(is_item(defer_self))
			var/obj/item/self_as_item = defer_self
			self_as_item.dropped_on_by_object(caller,object_as_item,location,control,params)
			return TRUE
		if(src.add_object(object_as_item))
			return TRUE

	return ..()

/obj/hud/inventory/get_object_to_damage_with(var/atom/attacker,var/atom/victim,params,var/accurate=FALSE,var/find_closet=FALSE)
	return src.loc

obj/hud/inventory/proc/drop_item_from_inventory(var/turf/new_location,var/pixel_x_offset = 0,var/pixel_y_offset = 0)

	if(!length(src.held_objects))
		return FALSE

	return get_top_held_object().drop_item(new_location,pixel_x_offset,pixel_y_offset)

/obj/hud/inventory/defer_click_on_object(location,control,params)

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