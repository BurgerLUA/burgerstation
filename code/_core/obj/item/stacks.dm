/obj/item/proc/can_transfer_stacks_to(var/obj/item/I)
	return istype(src,I) && I != src && I.item_count_max > 1

//Credit goes to Unknown Person

/proc/copy(var/atom/A)

	var/static/list/denyvar = make_associative(
		list(
			"client",
			"key",
			"loc",
			"x",
			"y",
			"z",
			"type",
			"locs",
			"parent_type",
			"verbs",
			"vars"
		)
	)

	var/atom/movable/N = new A.type(A.loc)

	for(var/i in A.vars)
		if(denyvar[i])
			continue
		try
			N.vars[i] = A.vars[i]
		catch()
			log_error("Cannot write var [i]!")

	N.loc = null

	return N

/obj/item/proc/split_stack()

	var/stacks_to_take = FLOOR(item_count_current/2, 1)
	if(!stacks_to_take)
		return FALSE
	var/obj/item/I = copy(src)
	I.force_move(get_turf(src))
	I.item_count_current = 0
	src.transfer_item_count_to(I,stacks_to_take)

	return I

/obj/item/click_on_object(var/mob/caller,var/atom/object,location,control,params)



	if(try_transfer_reagents(caller,object,location,control,params))
		return TRUE

	if(is_item(object))
		var/obj/item/I = object
		if(I.can_transfer_stacks_to(src))
			INTERACT_CHECK
			INTERACT_CHECK_OBJECT
			INTERACT_DELAY(10)
			var/stacks_transfered = I.transfer_item_count_to(src)
			if(stacks_transfered)
				caller.to_chat(span("notice","You transfer [stacks_transfered] stacks to \the [src.name]."))
			else
				caller.to_chat(span("warning","You can't transfer any more stacks to \the [src.name], it's full!"))
			return TRUE

	return ..()

/obj/item/clicked_on_by_object(var/mob/caller,var/atom/object,location,control,params)

	if(object == src || item_count_current <= 1 || !is_inventory(object) || !is_inventory(src.loc) || get_dist(src,object) > 1)
		return ..()

	INTERACT_CHECK
	INTERACT_CHECK_OBJECT
	INTERACT_DELAY(1)

	var/obj/hud/inventory/I = object
	var/old_item_name = src.name
	var/obj/item/I2 = split_stack()
	caller.to_chat(span("notice","You split \the stack of [old_item_name]. The new stack now has [I2.item_count_current]."))
	I.add_object(I2)
	return TRUE