/obj/hud/inventory/proc/grab_object(var/mob/caller as mob,var/atom/movable/object,location,control,params)

	if(!ismovable(object) || !object.can_be_grabbed(caller))
		return FALSE

	if(!isturf(caller.loc))
		return FALSE

	if(is_occupied())
		caller.to_chat(span("notice","You need an empty hand to grab this!"))
		return FALSE

	if(grabbed_object == object)
		caller.to_chat(span("notice","You cannot grab yourself, ERP is against the rules!"))
		return FALSE

	if(grabbed_object)
		release_object() //Release the old object, if any.

	if(object.grabbing_hand)
		object.grabbing_hand.release_object()

	caller.set_dir(get_dir(caller,object))

	grabbed_object = object
	caller.visible_message(span("warning","\The [caller.name] grabs \the [object.name]."),span("notice","You grab \the [object.name]."))
	animate(grabbed_object,pixel_x = initial(grabbed_object.pixel_x), pixel_y = initial(grabbed_object.pixel_y), time = SECONDS_TO_DECISECONDS(1))
	grabbed_object.grabbing_hand = src
	grab_time = world.time //To prevent instant agressive grab

	overlays.Cut()
	update_overlays()

	return TRUE

/obj/hud/inventory/proc/check_grab()

	if(!grabbed_object)
		return FALSE

	if(!grabbed_object.can_be_grabbed(owner) || !can_grab(owner,grabbed_object))
		release_object(owner)
		return FALSE

	return TRUE

/obj/hud/inventory/proc/release_object(var/mob/caller as mob)
	if(!grabbed_object)
		return FALSE
	if(caller) caller.to_chat(span("notice","You release \the [grabbed_object.name]."))
	if(is_living(grabbed_object))
		var/mob/living/L = grabbed_object
		L.next_resist = 0
		L.resist_counter = 0
	grabbed_object.grabbing_hand = null
	grabbed_object = null
	grab_level = 1
	overlays.Cut()
	update_overlays()
	return TRUE

/obj/hud/inventory/proc/can_grab(var/mob/caller,var/atom/movable/object)

	if(!object || !caller)
		return FALSE

	if(get_dist(caller,object) >= 2)
		return FALSE

	if(!isturf(caller.loc))
		return FALSE

	return TRUE
