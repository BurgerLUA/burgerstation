/obj/hud/inventory/click_on_object(var/mob/caller as mob,var/atom/object,location,control,params) //The src is used on the object

	if(caller.attack_flags & ATTACK_THROW) //Throw the object if we are telling it to throw.
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

			vel_x *= 28
			vel_y *= 28

			I.drop_item(get_turf(caller))
			I.throw_self(caller,get_turf(object),text2num(params[PARAM_ICON_X]),text2num(params[PARAM_ICON_Y]),vel_x,vel_y)

		return TRUE
	else if(caller.attack_flags & ATTACK_DROP) //Drop the object if we are telling it to drop.

		if(grabbed_object)
			return release_object(caller)

		var/turf/caller_turf = get_turf(caller)
		var/turf/desired_turf = object ? get_turf(object) : null

		if(desired_turf && get_dist(caller_turf,desired_turf) <= 1)
			return drop_item(desired_turf,text2num(params[PARAM_ICON_X])-16,text2num(params[PARAM_ICON_Y])-16)

		return drop_item()

	else if(grabbed_object && grabbed_object == object)
		return release_object(caller,object,location,control,params)
	else if(object && caller.attack_flags & ATTACK_GRAB && get_dist(caller,object) <= 1)
		return grab_object(caller,object,location,control,params)

	var/atom/defer_self = src.defer_click_on_object() //We could be holding an object.
	var/atom/defer_object = object.defer_click_on_object() //The object we're clicking on could be something else.

	if((caller.attack_flags & ATTACK_SELF || defer_self == defer_object) && defer_self.click_self(caller)) //Click on ourself if we're told to click on ourself.
		return TRUE

	if(is_inventory(object) && is_item(defer_self)) //We're clicking on an inventory with an item.
		var/obj/hud/inventory/object_as_inventory = object
		var/obj/item/defer_self_as_item = defer_self
		if(object_as_inventory.held_slots > 1 || object_as_inventory.worn_slots > 1) //The inventory we're clicking on can hold more than one object per slot.
			defer_self_as_item.transfer_item(object_as_inventory)
			return TRUE

	if(src == defer_self && is_item(defer_object) && get_dist(caller,defer_object) <= 1) //We're clicking on an item with an empty hand, and it is in range.
		var/obj/item/defer_object_as_item = defer_object
		if(is_inventory(object)) //The item in question is in another inventory.
			var/obj/hud/inventory/object_as_inventory = object
			if(!defer_object_as_item.is_container && !object_as_inventory.drag_to_take && defer_object_as_item.transfer_item(src))
				return TRUE
		else if (!defer_object_as_item.anchored && defer_object_as_item.transfer_item(src))
			return TRUE

	if(is_item(defer_self))
		var/obj/item/defer_self_as_item = defer_self
		if(is_inventory(defer_object)) //We have an item in hand and the object we're clicking on is a blank inventory
			var/obj/hud/inventory/defer_object_as_inventory = defer_object
			if(get_dist(defer_self_as_item,defer_object_as_inventory) <= 1 && defer_self_as_item.transfer_item(defer_object_as_inventory))
				return TRUE

	return ..()

/obj/hud/inventory/dropped_on_by_object(var/atom/caller,var/atom/object)

	. = ..()

	if(!. && is_item(object))
		var/obj/item/object_as_item = object
		if(object_as_item.transfer_item(src))
			return TRUE

	return .

/obj/hud/inventory/get_object_to_damage_with(var/atom/attacker,var/atom/victim,params)
	return src.loc

obj/hud/inventory/drop_item(var/turf/new_location,var/pixel_x_offset = 0,var/pixel_y_offset = 0)

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