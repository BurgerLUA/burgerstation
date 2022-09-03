/obj/hud/inventory/proc/grab_object(var/mob/caller as mob,var/atom/movable/object,location,control,params)

	if(caller == object)
		caller.to_chat(span("notice","You cannot grab yourself, ERP is against the rules!"))
		return FALSE

	if(!ismovable(object) || !object.can_be_grabbed(caller))
		return FALSE

	if(!isturf(caller.loc))
		return FALSE

	if(grabbed_object)
		if(grabbed_object == object)
			if(is_living(grabbed_object))
				return reinforce_grab(caller)
			else
				release_object(caller)
				return TRUE
		release_object(caller) //Release the old object, if any.

	if(is_occupied())
		caller.to_chat(span("notice","You need an empty hand to grab this!"))
		return FALSE

	if(get_dist(caller,object) > 1)
		if(next_move > 0 || !caller.Move(get_step(caller.loc,get_dir(caller,object))))
			caller.to_chat(span("notice","You're too far away!"))
			return FALSE

	if(object.grabbing_hand) //Someone else is grabbing already.
		if(object.grabbing_hand.grab_level >= 2)
			caller.to_chat(span("warning","\The [object.grabbing_hand.owner.name] has too strong of a grip on \the [object.name]!"))
			return FALSE
		else
			object.grabbing_hand.release_object(caller)

	caller.set_dir(get_dir(caller,object))
	grabbed_object = object
	caller.visible_message(span("warning","\The [caller.name] grabs \the [object.name]."),span("notice","You grab \the [object.name]."))
	grabbed_object.grabbing_hand = src
	grab_time = world.time //To prevent instant agressive grab
	overlays.Cut()
	update_overlays()
	if(is_living(grabbed_object))
		var/mob/living/L = grabbed_object
		L.handle_transform()
		L.stat_elements_to_update |= L.stat_elements["resist"]
	HOOK_CALL_ADV("grab_changed",owner,args)

	return TRUE

/obj/hud/inventory/proc/check_grab()

	if(!grabbed_object)
		return FALSE

	if(!grabbed_object.can_be_grabbed(owner) || !can_grab(owner,grabbed_object))
		release_object(owner)
		return FALSE

	return TRUE

/obj/hud/inventory/proc/release_object(var/mob/caller)
	if(!grabbed_object)
		return FALSE
	if(caller && owner)
		if(caller == owner)
			caller.to_chat(span("notice","You release \the [grabbed_object.name]."))
		else
			owner.visible_message(
				span("danger","\The [caller.name] forces \the [owner.name] to release their grip on \the [grabbed_object.name]!"),
				span("danger","\The [caller.name] forces you to release your grip on \the [grabbed_object.name]!")
			)
	var/mob/living/L
	if(is_living(grabbed_object))
		L = grabbed_object
		L.next_resist = 0
		L.resist_counter = 0
		L.resist_percent = 0
	grabbed_object.grabbing_hand = null
	grabbed_object = null
	grab_level = 1
	overlays.Cut()
	update_overlays()
	if(L)
		L.handle_transform()
	if(owner) HOOK_CALL_ADV("grab_changed",owner,args)
	return TRUE

/obj/hud/inventory/proc/can_grab(var/mob/caller,var/atom/movable/object)

	if(!object || !caller)
		return FALSE

	if(get_dist(caller,object) >= 2)
		return FALSE

	if(!isturf(caller.loc))
		return FALSE

	return TRUE

/obj/hud/inventory/proc/reinforce_grab(var/mob/caller)

	if(world.time <= grab_time+SECONDS_TO_DECISECONDS(2)) //Prevents insta agressive-grab
		return FALSE

	if(grab_level > 1)
		return FALSE

	var/mob/living/grabbed_living = grabbed_object
	caller.visible_message(
		span("warning","\The [caller.name] tightens their grip on \the [grabbed_living.name]!"),
		span("warning","You tighten your grip on \the [grabbed_living.name]!")
	)

	grab_level = 2 //Agressive grab
	grab_time = world.time
	grabbed_living.add_status_effect(DISARM)
	grabbed_living.handle_transform()

	if(caller.next_move <= 0)
		caller.Move(get_turf(grabbed_object))

	update_overlays() //Changing the appearance of the inventory.

	return TRUE