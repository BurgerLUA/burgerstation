/obj/hud/inventory/click_self(var/mob/caller)

	if(src.defer_click_on_object() != src)
		return ..()

	if(!is_advanced(caller))
		return ..()

	var/mob/living/advanced/A = caller

	if(id == BODY_HAND_LEFT)
		if(!A.right_hand)
			return FALSE
		return src.click_on_object(caller,A.right_hand)
	else if(id == BODY_HAND_RIGHT)
		if(!A.left_hand)
			return FALSE
		return src.click_on_object(caller,A.left_hand)

	return ..()

/obj/hud/inventory/click_on_object(var/mob/caller as mob,var/atom/object,location,control,params) //The src is used on the object

	if(is_living(caller))
		var/mob/living/L = caller
		if(L.dead && !(object.interaction_flags & FLAG_INTERACTION_DEAD))
			L.to_chat(span("warning","You're dead!"))
			return FALSE

		if(caller.attack_flags & ATTACK_HOLD)
			L.dash(object,0x0,2)
			return TRUE


	var/atom/defer_self = src.defer_click_on_object(location,control,params) //We could be holding an object.
	var/atom/defer_object = object.defer_click_on_object(location,control,params) //The object we're clicking on could be something else.

	if(caller.attack_flags & ATTACK_GRAB)
		if(is_item(defer_object) && is_inventory(defer_object.loc))
			toggle_wield(caller,defer_object)
			return TRUE
		if(isturf(object.loc) && get_dist(caller,object) <= 1)
			if(is_living(object))
				var/mob/living/L = object
				if(!L.add_status_effect(GRAB, source = caller))
					caller.to_chat(span("warning","\The [object.name] is too strong to be grabbed!"))
					return TRUE
			grab_object(caller,object,location,control,params)
			return TRUE


	if(caller.attack_flags & ATTACK_ALT && ismovable(defer_object))
		var/atom/movable/M = defer_object
		if(!M.anchored && M.can_rotate)
			var/rotation = -90
			if(click_flags & LEFT_HAND)
				rotation = 90
			M.set_dir(turn(M.dir,rotation))
			caller.to_chat(span("notice","You rotate \the [M.name] [rotation == -90 ? "clockwise" : "counter-clockwise"]."))
			return TRUE //Needs to be here. At this level.

	if(caller.attack_flags & ATTACK_THROW && is_living(caller)) //Throw the object if we are telling it to throw.
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

			vel_x *= BULLET_SPEED_LARGE_PROJECTILE
			vel_y *= BULLET_SPEED_LARGE_PROJECTILE

			I.drop_item(get_turf(caller))
			I.throw_self(caller,get_turf(object),text2num(params[PARAM_ICON_X]),text2num(params[PARAM_ICON_Y]),vel_x,vel_y,steps_allowed = VIEW_RANGE,lifetime = 30,desired_iff = L.iff_tag)
		return TRUE

	if(caller.attack_flags & ATTACK_DROP) //Drop the object if we are telling it to drop.
		if(parent_inventory)
			var/obj/item/I = parent_inventory.get_top_held_object()
			return unwield(caller,I)
		if(grabbed_object)
			return release_object(caller)
		var/turf/caller_turf = get_turf(caller)
		var/turf/desired_turf = object ? get_turf(object) : null
		if(desired_turf && istype(object,/obj/structure/smooth/table) && get_dist(caller_turf,desired_turf) <= 1)
			return drop_item_from_inventory(desired_turf,text2num(params[PARAM_ICON_X])-16,text2num(params[PARAM_ICON_Y])-16)
		return drop_item_from_inventory()

	if(grabbed_object && grabbed_object == object)
		return release_object(caller)

	if(defer_self == grabbed_object)
		if(isturf(object) && (get_dist(caller,object) <= 1 || get_dist(object,grabbed_object) <= 1))
			var/desired_move_dir = get_dir(grabbed_object,object)
			grabbed_object.Move(get_step(grabbed_object.loc,desired_move_dir))
		return TRUE

	if(caller.attack_flags & ATTACK_OWNER)
		if(defer_self != src)
			defer_self.click_on_object(caller,caller,location,control,params)
		else if(object != src)
			object.click_on_object(caller,caller,location,control,params)
		return TRUE

	if(params && (caller.attack_flags & ATTACK_SELF || defer_self == defer_object) && defer_self.click_self(caller)) //Click on ourself if we're told to click on ourself.
		return TRUE


	if(get_dist(defer_self,defer_object) <= 1)
		if(is_item(defer_object)) //We're clicking on another item.
			var/obj/item/I = defer_object
			if(I.anchored)
				I.click_self(caller)
				return TRUE
			if(is_inventory(defer_object.loc)) //The object we're clicking on is in an inventory. Special behavior.
				var/obj/hud/inventory/I2 = defer_object.loc
				if(I.is_container && !istype(I2,/obj/hud/inventory/dynamic)) //The object that we're clicking on is a container in a worn slot.
					if(is_inventory(defer_self)) //We have nothing to add to it, so we should open it instead.
						I.click_self(caller)
						return TRUE
				if(!I2.click_flags && !I2.drag_to_take && is_item(defer_object) && !is_item(defer_self))
					src.add_object(defer_object)
					return TRUE
				if(I2.worn_slots && is_item(defer_self) && !I.is_container)
					I2.add_object(defer_self)
					return TRUE
			else if(is_inventory(defer_self))
				src.add_object(defer_object)
				return TRUE

		else if(is_item(defer_self)) //We have an object in our hands, clicking on an empty inventory.
			if(is_inventory(object)) //We're clicking on an inventory. It may or may not have an object.
				var/obj/hud/inventory/object_as_inventory = object
				object_as_inventory.add_object(defer_self)
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

/obj/hud/inventory/proc/toggle_wield(var/mob/caller,var/obj/item/item_to_wield)

	if(parent_inventory)
		unwield(caller,item_to_wield)
	else
		wield(caller,item_to_wield)

	return TRUE


/obj/hud/inventory/proc/can_wield(var/mob/caller,var/obj/item/item_to_wield)

	if(src.is_occupied(ignore_worn=TRUE))
		caller.to_chat(span("warning","Your hand must be unoccupied in order to wield this!"))
		return FALSE

	if(!is_inventory(item_to_wield.loc) || item_to_wield.loc == src)
		caller.to_chat(span("warning","You must be holding this object in another hand in order to wield this!"))
		return FALSE

	var/obj/hud/inventory/holding = item_to_wield.loc

	if(!(holding.click_flags & (LEFT_HAND | RIGHT_HAND)))
		caller.to_chat(span("warning","You must be holding this object in another hand in order to wield this!"))
		return FALSE

	return TRUE



/obj/hud/inventory/proc/unwield(var/mob/caller,var/obj/item/item_to_wield)

	caller.to_chat(span("notice","You unbrace \the [item_to_wield] with your [src.loc.name]."))

	var/obj/hud/inventory/holding = item_to_wield.loc

	if(holding && is_inventory(holding))
		holding.child_inventory = null
	else
		CRASH_SAFE("ERRROR: unwield() variable holding wasn't valid ([holding])!")

	src.parent_inventory = null
	item_to_wield.wielded = null

	update_sprite()
	item_to_wield.update_sprite()
	return TRUE


/obj/hud/inventory/proc/wield(var/mob/caller,var/obj/item/item_to_wield)

	if(!is_item(item_to_wield) || !item_to_wield.can_wield)
		caller.to_chat(span("warning","You can't wield this!"))
		return FALSE

	if(src.parent_inventory)
		caller.to_chat(span("warning","You are already wielding something!"))
		return FALSE

	if(!can_wield(caller,item_to_wield))
		return FALSE

	caller.to_chat(span("notice","You brace \the [item_to_wield] with your [src.loc.name]."))

	var/obj/hud/inventory/holding = item_to_wield.loc

	item_to_wield.wielded = TRUE
	src.parent_inventory = holding
	holding.child_inventory = src

	update_sprite()
	item_to_wield.update_sprite()

	return TRUE



/obj/hud/inventory/dropped_on_by_object(var/mob/caller,var/atom/object,location,control,params) //Object dropped on src

	var/atom/defer_object = object.defer_click_on_object(location,control,params)

	if(is_item(defer_object) && get_dist(caller,object) <= 1) //Put the itme in the inventory slot.
		var/obj/item/object_as_item = defer_object
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