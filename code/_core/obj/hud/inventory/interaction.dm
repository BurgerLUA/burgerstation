/obj/hud/inventory/click_on_object(var/mob/caller as mob,var/atom/object,location,control,params) //The src is used on the object

	var/atom/top_object = get_top_object()

	//Test
	if(is_living(caller)) //TODO: Do you even need this?
		var/mob/living/L = caller
		if(L.dead && !(object.interaction_flags & FLAG_INTERACTION_DEAD))
			L.to_chat(span("warning","You're dead!"))
			return TRUE

	if(!top_object && caller.attack_flags & CONTROL_MOD_GRAB) //Grabbing with an empty hand.
		if(is_item(object) && is_inventory(object.loc))
			var/obj/item/I = object
			if(!I.is_container)
				toggle_wield(caller,object)
				return TRUE
		if(is_organ(src.loc) && isturf(object.loc) && get_dist(caller,object) <= 1)
			var/obj/item/organ/O = src.loc
			if(ismob(object))
				O.attack(caller,object,params,damage_type_override=/damagetype/unarmed/fists/grab)
			else
				src.grab_object(caller,object,location,control,params)
			return TRUE

	if(!top_object && caller.attack_flags & CONTROL_MOD_DISARM && ismovable(object)) //Alt clicking with an empty hand.
		var/atom/movable/M = object
		if(!M.anchored && M.can_rotate)
			var/rotation = -90
			if(click_flags & LEFT_HAND)
				rotation = 90
			M.set_dir(turn(M.dir,rotation))
			caller.to_chat(span("notice","You rotate \the [M.name] [rotation == -90 ? "clockwise" : "counter-clockwise"]."))
			return TRUE //Needs to be here. At this level.

	if(caller.attack_flags & CONTROL_MOD_THROW && is_living(caller)) //Throw the object if we are telling it to throw.
		if(!isturf(caller.loc))
			return TRUE
		var/mob/living/L = caller
		caller.face_atom(object)
		var/atom/movable/object_to_throw = top_object
		if(istype(object_to_throw))
			var/obj/item/I = object_to_throw
			if(I.additional_clothing_parent)
				caller.to_chat(span("warning","You can't throw this!"))
				return TRUE
			var/vel_x = object.x - caller.x
			var/vel_y = object.y - caller.y
			var/highest = max(abs(vel_x),abs(vel_y))

			if(!highest)
				I.drop_item(get_turf(caller)) //Drop if we can't throw.
				return TRUE

			vel_x *= 1/highest
			vel_y *= 1/highest

			vel_x *= BULLET_SPEED_LARGE_PROJECTILE
			vel_y *= BULLET_SPEED_LARGE_PROJECTILE

			I.drop_item(get_turf(caller),silent=TRUE)
			I.throw_self(caller,get_turf(object),text2num(params[PARAM_ICON_X]),text2num(params[PARAM_ICON_Y]),vel_x,vel_y,steps_allowed = VIEW_RANGE,lifetime = 30,desired_iff = L.iff_tag)
		else if(top_object)
			caller.to_chat(span("warning","You can't throw \the [top_object.name]!"))

		return TRUE

	if(caller.attack_flags & CONTROL_MOD_DROP) //Drop the object if we are telling it to drop.
		if(parent_inventory)
			var/obj/item/I = parent_inventory.get_top_object()
			unwield(caller,I)
			return TRUE
		if(grabbed_object)
			release_object(caller)
			return TRUE
		if(!isturf(caller.loc))
			return TRUE
		var/turf/caller_turf = get_turf(caller)
		var/turf/desired_turf = object ? get_turf(object) : null
		if(desired_turf && istype(object,/obj/structure/smooth/table) && get_dist(caller_turf,desired_turf) <= 1)
			drop_item_from_inventory(desired_turf,text2num(params[PARAM_ICON_X])-16,text2num(params[PARAM_ICON_Y])-16)
		else
			drop_item_from_inventory(get_turf(src))
		return TRUE

	if(grabbed_object && grabbed_object == object)
		release_object(caller)
		return TRUE

	if(grabbed_object && isturf(grabbed_object.loc)) //Handle moving grabbed objects
		if(isturf(object) && (get_dist(caller,object) <= 1 || get_dist(object,grabbed_object) <= 1))
			var/desired_move_dir = get_dir(grabbed_object,object)
			var/turf/T = get_step(grabbed_object.loc,desired_move_dir)
			if(is_living(grabbed_object) && is_living(caller))
				var/mob/living/L = grabbed_object
				var/mob/living/C = caller
				var/turf/grabbed_object_turf = grabbed_object.loc
				if(C.loyalty_tag && L.loyalty_tag == C.loyalty_tag && grabbed_object_turf.is_safe_teleport(FALSE) && !T.is_safe_teleport(FALSE))
					return TRUE
			grabbed_object.Move(T)
		return TRUE

	if(caller.attack_flags & CONTROL_MOD_OWNER && top_object)
		top_object.click_on_object(caller,caller,location,control,params)
		return TRUE

	//Self clicking.
	if(top_object && (object == top_object || caller.attack_flags & CONTROL_MOD_SELF)) //Click on ourself
		top_object.click_self(caller)
		return TRUE
	else if(caller.attack_flags & CONTROL_MOD_SELF)
		if(is_advanced(caller))
			var/mob/living/advanced/A = caller
			if(src == A.right_hand && A.left_item)
				A.right_hand.toggle_wield(caller,A.left_item)
				return TRUE
			if(src == A.left_hand && A.right_item)
				A.left_hand.toggle_wield(caller,A.right_item)
				return TRUE

	if(get_dist(src,object) <= 1 && (is_inventory(object) || is_inventory(object.loc) || isturf(object) || isturf(object.loc)) && !(isturf(object.loc) && !isturf(caller.loc)) )
		if(is_item(object)) //We're clicking on another item.
			var/obj/item/I = object
			if(I.is_container && (I.anchored || !isturf(I)) && caller.attack_flags & CONTROL_MOD_GRAB) //We're clicking on a container and we want to quickly grab the first object.
				var/obj/item/found_item
				for(var/k in I.inventories)
					var/obj/hud/inventory/INV = k
					found_item = INV.get_top_object()
					if(found_item)
						src.add_object(found_item)
						return TRUE
			if(!I.anchored) //If it's anchored, we just call click_self on it.
				if(is_inventory(I.loc)) //The object we're clicking on is in an inventory. Special behavior.
					var/obj/hud/inventory/INV = I.loc
					if(!top_object) //We're clicking on an object with an empty hand.
						if(INV.worn) //We're clicking on a worn object.
							var/content_length = length(INV.contents)
							if(content_length > 1 && caller.attack_flags & CONTROL_MOD_DISARM) //Force
								content_length -= 1
							for(var/i=content_length,i>0,i--)
								var/obj/item/ITM = INV.contents[i]
								if(ITM.click_self(caller))
									return TRUE
						if(I.is_container && !istype(INV,/obj/hud/inventory/dynamic)) //The object that we're clicking on is a container in non-dynamic inventory (organ inventory).
							I.click_self(caller)
							return TRUE
						if(!INV.click_flags && (!INV.drag_to_take || is_weapon(object))) //The object we're clicking on is not in hands, and it's not in an inventory with drag to take enabled.
							if(caller.attack_flags & CONTROL_MOD_DISARM)
								I.click_self(caller)
							else
								src.add_object(object)
							return TRUE
					else if(INV.worn && !I.is_container && INV.add_object(top_object)) //The item we're clicking on is not a container and it's in a worn inventory, and it can be added.
						return TRUE
				else if(!top_object) //If we don't have a top object, pick it up.
					src.add_object(object)
					return TRUE
		else if(top_object && is_inventory(object)) //We have an object in our hands, clicking on an empty inventory.
			var/obj/hud/inventory/INV = object
			INV.add_object(top_object)
			return TRUE

	//Here be shitcode territory. We're overriding what is normally called.
	//Should change this in the future.

	if(top_object && top_object.click_on_object(caller,object,location,control,params))
		return TRUE

	if(object.clicked_on_by_object(caller,top_object ? top_object : src,location,control,params))
		return TRUE

	if(top_object)
		top_object.attack(caller,object,params)
		return TRUE

	if(is_organ(src.loc)) //We belong to an organ, so we should attack.
		var/obj/item/organ/O = src.loc
		O.attack(caller,object,params)
		return TRUE

	return TRUE //Returning TRUE here as returning false would just run the above.

/obj/hud/inventory/proc/toggle_wield(var/mob/caller,var/obj/item/item_to_wield)

	if(parent_inventory)
		unwield(caller,item_to_wield)
	else
		wield(caller,item_to_wield)

	return TRUE


/obj/hud/inventory/proc/can_wield(var/mob/caller,var/obj/item/item_to_wield)

	if(src.is_occupied())
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

	DEFER_OBJECT

	if(is_item(defer_object)) //Put the item in this inventory slot.
		var/obj/item/object_as_item = defer_object
		INTERACT_CHECK
		INTERACT_CHECK_DEFER
		INTERACT_DELAY(1)
		src.add_object(object_as_item)
		return TRUE

	. = ..()

/obj/hud/inventory/get_object_to_damage_with(var/atom/attacker,var/atom/victim,params,var/accurate=FALSE,var/find_closet=FALSE)
	return src.loc

obj/hud/inventory/proc/drop_item_from_inventory(var/turf/new_location,var/pixel_x_offset = 0,var/pixel_y_offset = 0,var/silent=FALSE)

	var/obj/item/I = get_top_object()

	if(!I)
		return null

	return I.drop_item(new_location,pixel_x_offset,pixel_y_offset)

/obj/hud/inventory/defer_click_on_object(var/mob/caller,location,control,params)

	var/contents_length = length(contents)

	if(worn && contents_length > 1)
		for(var/i=contents_length,i>0,i--)
			var/obj/item/I = contents[i]
			if(I.is_container)
				return I

	if(grabbed_object)
		return grabbed_object

	var/obj/item/I = get_top_object()
	if(I) return I

	return src


/obj/hud/inventory/on_mouse_up(var/mob/caller as mob, var/atom/object,location,control,params)

	var/atom/top_object = get_top_object()

	if(top_object && top_object.on_mouse_up(caller,object,location,control,params))
		return TRUE

	. = ..()