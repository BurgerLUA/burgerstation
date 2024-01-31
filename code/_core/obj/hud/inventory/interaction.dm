/obj/hud/inventory/click_on_object(var/mob/caller as mob,var/atom/object,location,control,params) //The src is used on the object

	//Dead can't interact.
	if(is_living(caller))
		var/mob/living/L = caller
		if(L.dead && !(object.interaction_flags & FLAG_INTERACTION_DEAD))
			L.to_chat(span("warning","You're dead!"))
			return TRUE
		//Reinforced grabbing. Doesn't matter what your intent is as long as you're clicking with the same hand.
		if(grabbed_object && grabbed_object == object && is_living(object))
			reinforce_grab(caller)
			return TRUE

	 //Wielding an object.
	if(parent_inventory)
		var/atom/top_object = parent_inventory.get_top_object()
		if(object != top_object && top_object.click_on_object_alt(caller,object,location,control,params))
			return TRUE

	var/atom/top_object = src.get_top_object() //What is in our inventory.

	//Alt click a corpse with an empty hand.
	if(!top_object && caller.attack_flags & CONTROL_MOD_DISARM && is_advanced(object))
		var/mob/living/advanced/A = object
		if(A.dead)
			A.examine_body_inventory(caller)
			return TRUE

	//Grabbing with an empty hand.
	if(!top_object && caller.attack_flags & CONTROL_MOD_GRAB)
		if(is_item(object))
			var/obj/item/I = object
			if(istype(I.loc,/obj/item/plate))
				src.add_object(I)
				return TRUE
			if(is_inventory(I.loc) && !I.is_container)
				toggle_wield(caller,object)
				return TRUE
		if(is_organ(src.loc) && is_turf(object.loc) && get_dist(caller,object) <= 1)
			var/obj/item/organ/O = src.loc
			if(ismob(object))
				O.attack(caller,object,params,damage_type_override=/damagetype/unarmed/fists/grab)
			else
				src.grab_object(caller,object,location,control,params)
			return TRUE

	//Snowflake code for plates.
	if(istype(object.loc,/obj/item/plate)) //Plate fuckery.
		return src.click_on_object(caller,object.loc,location,control,params)

	//Alt clicking a movable, rotatable with an empty hand.
	if(!top_object && caller.attack_flags & CONTROL_MOD_DISARM && ismovable(object))
		var/atom/movable/M = object
		if(!M.anchored && M.can_rotate)
			var/rotation = -90
			if(click_flags & LEFT_HAND)
				rotation = 90
			M.set_dir(turn(M.dir,rotation))
			caller.to_chat(span("notice","You rotate \the [M.name] [rotation == -90 ? "clockwise" : "counter-clockwise"]."))
			return TRUE //Needs to be here. At this level.

	//Throw the object if we are telling it to throw.
	if(caller.attack_flags & CONTROL_MOD_THROW && is_living(caller))
		if(!is_turf(caller.loc))
			return TRUE
		var/mob/living/L = caller
		caller.face_atom(object) //Changing dir
		var/atom/movable/object_to_throw
		if(grabbed_object)
			object_to_throw = grabbed_object //We want to throw something that we pull
		else
			object_to_throw = top_object //Else we throw something in our hand

		if(istype(object_to_throw))
			if(is_living(object_to_throw))
				if(!allow_hostile_action(L.loyalty_tag,object_to_throw))
					caller.to_chat(span("warning","You can't throw allies!"))
					return TRUE
				if(grab_level < 2) //To throw mob you need an agressive grab
					caller.to_chat(span("warning","You need a better grip to do that!"))
					return TRUE
			var/vel_x = object.x - caller.x //Caller pos is the same as object anyway
			var/vel_y = object.y - caller.y
			var/highest = max(abs(vel_x),abs(vel_y))

			if(is_item(object_to_throw)) //Item needs aditional procedures
				var/obj/item/I = object_to_throw
				if(I.additional_clothing_parent || I.no_drop) //Can't throw additional clothing
					caller.to_chat(span("warning","You can't throw this!"))
					return TRUE
				if(!highest) //We want to throw it in us?.. No velocity
					I.drop_item(get_turf(caller)) //Drop if we can't throw.
					return TRUE
				I.drop_item(get_turf(caller),silent=TRUE)

			if(highest == 0) //Our position is the same as target
				release_object(caller) //Better not to divide by zero
				return TRUE

			vel_x *= 1/highest
			vel_y *= 1/highest //Should it be in two lines instead of four?
			vel_x *= BULLET_SPEED_LARGE_PROJECTILE
			vel_y *= BULLET_SPEED_LARGE_PROJECTILE

			if(grabbed_object == object_to_throw)
				grabbed_object.Move(get_turf(caller)) //Anti-offset
				release_object(caller)

			var/list/target_cords = L.get_current_target_cords(params)
			//Throwing it
			object_to_throw.throw_self((grabbed_object ? grabbed_object : caller),object,target_cords[1],target_cords[2],vel_x,vel_y,lifetime=SECONDS_TO_DECISECONDS(1),desired_loyalty_tag = L.loyalty_tag)

		else if(top_object)
			caller.to_chat(span("warning","You can't throw \the [top_object.name]!"))

		return TRUE

	//Drop the object if we are telling it to drop.
	if(caller.attack_flags & CONTROL_MOD_DROP)
		if(parent_inventory)
			var/obj/item/I = parent_inventory.get_top_object()
			unwield(caller,I)
			return TRUE
		if(is_item(top_object))
			var/obj/item/I = top_object
			if(I.no_drop)
				caller.to_chat(span("warning","You can't drop this!"))
				return TRUE
		if(grabbed_object)
			release_object(caller)
			return TRUE
		if(!is_turf(caller.loc))
			return TRUE
		var/turf/caller_turf = get_turf(caller)
		var/turf/desired_turf = object ? get_turf(object) : null
		if(desired_turf && (istype(object,/obj/structure/table) || istype(object,/obj/item/plate)) && get_dist(caller_turf,desired_turf) <= 1)
			drop_item_from_inventory(desired_turf,params[PARAM_ICON_X]-16,params[PARAM_ICON_Y]-16)
		else
			drop_item_from_inventory(get_turf(src))
		return TRUE

	//Special owner-clicking shortcut.
	if(caller.attack_flags & CONTROL_MOD_OWNER && top_object)
		top_object.click_on_object(caller,caller,location,control,params)
		return TRUE

	//Self clicking.
	if(top_object && (object == top_object || caller.attack_flags & CONTROL_MOD_SELF)) //Click on ourself
		top_object.click_self(caller)
		return TRUE
	else if(caller.attack_flags & CONTROL_MOD_SELF) //Z click wielding.
		if(is_advanced(caller))
			var/mob/living/advanced/A = caller
			var/obj/item/right_item = A.inventories_by_id[BODY_HAND_RIGHT_HELD]?.get_top_object()
			var/obj/item/left_item = A.inventories_by_id[BODY_HAND_LEFT_HELD]?.get_top_object()
			if(src == A.inventories_by_id[BODY_HAND_RIGHT_HELD] && left_item)
				A.inventories_by_id[BODY_HAND_RIGHT_HELD].toggle_wield(caller,left_item)
				return TRUE
			if(src == A.inventories_by_id[BODY_HAND_LEFT_HELD] && right_item)
				A.inventories_by_id[BODY_HAND_LEFT_HELD].toggle_wield(caller,right_item)
				return TRUE

	//Handle moving grabbed objects
	if(grabbed_object && is_turf(grabbed_object.loc))
		if(is_turf(object) && (get_dist(caller,object) <= 1 || get_dist(object,grabbed_object) <= 1))
			var/desired_move_dir = get_dir(grabbed_object,object)
			var/turf/desired_move_turf = get_step(grabbed_object.loc,desired_move_dir)
			if(is_living(grabbed_object) && is_living(caller))
				var/mob/living/L = grabbed_object
				var/mob/living/C = caller
				var/turf/grabbed_object_turf = grabbed_object.loc
				if(!allow_hostile_action(C.loyalty_tag,L) && grabbed_object_turf.is_safe() && !desired_move_turf.is_safe())
					return TRUE
			grabbed_object.Move(desired_move_turf)
			if(is_living(grabbed_object))
				var/mob/living/L = grabbed_object
				L.handle_transform()
		return TRUE

	//Checking if the object we're clicking on can even be interacted with. If all the above fail, it's probably an item.
	if(object.plane >= PLANE_HUD || (object.loc && object.loc.plane >= PLANE_HUD) || is_turf(object) || is_turf(object.loc)) // Only interact with objects that can actually be clicked on.
		if(get_dist(src,object) <= 1)
			if(is_item(object)) //We're clicking on another item.
				var/obj/item/I = object
				if(I.is_container && (I.anchored || !is_turf(I)) && caller.attack_flags & CONTROL_MOD_GRAB) //We're clicking on a container and we want to quickly grab the first object.
					var/obj/item/found_item
					for(var/k in I.inventories)
						var/obj/hud/inventory/INV = k
						found_item = INV.get_top_object()
						if(found_item)
							src.add_object(found_item)
							return TRUE
				if(!I.anchored) //If it's anchored, we just call click_self on it (later in the code).
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
							if(!INV.click_flags && (!INV.drag_to_take || !is_clothing(object))) //The object we're clicking on is not in hands, and it's not in an inventory with drag to take enabled.
								if(caller.attack_flags & CONTROL_MOD_DISARM)
									I.click_self(caller)
								else
									src.add_object(object)
								return TRUE
						else if(INV.worn && !I.is_container && INV.add_object(top_object)) //The item we're clicking on is not a container and it's in a worn inventory, and it can be added.
							return TRUE
					else if(!top_object && caller.attack_flags && !(caller.attack_flags & ~(CONTROL_MOD_LEFT|CONTROL_MOD_RIGHT)) ) //If we don't have a top object and we don't have any non-left attack flags, pick it up.
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

	if(is_inventory(holding))
		holding.child_inventory = null

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

/obj/hud/inventory/get_object_to_damage_with(var/atom/attacker,var/atom/victim,var/list/params=list(),var/accurate=FALSE,var/find_closet=FALSE)
	return src.loc

obj/hud/inventory/proc/drop_item_from_inventory(var/turf/new_location,var/pixel_x_offset = 0,var/pixel_y_offset = 0,var/silent=FALSE)

	var/obj/item/I = get_top_object()

	if(!I)
		return null

	return I.drop_item(new_location,pixel_x_offset,pixel_y_offset)

/obj/hud/inventory/defer_click_on_object(var/mob/caller,location,control,params)

	if(grabbed_object)
		return grabbed_object

	var/atom/A = get_top_object()
	if(A) return A

	return src

/obj/hud/inventory/on_mouse_up(var/mob/caller as mob, var/atom/object,location,control,params)

	var/atom/top_object = get_top_object()

	if(top_object && top_object.on_mouse_up(caller,object,location,control,params))
		return TRUE

	. = ..()
