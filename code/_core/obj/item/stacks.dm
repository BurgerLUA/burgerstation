/obj/item/proc/can_transfer_stacks_to(var/obj/item/I)
	return istype(src,I) && I != src

//Credit goes to Unknown Person

/proc/copy(var/atom/A)

	var/static/list/denyvar = make_associative(list("client","key","loc","x","y","z","type","locs","parent_type","verbs","vars"))

	var/atom/N = new A.type(A.loc)

	for(var/i in A.vars)
		if(denyvar[i])
			continue
		try
			N.vars[i] = A.vars[i]
		catch()
			log_error("Cannot write var [i]!")

	//INITIALIZE(N)

	return N

/obj/item/proc/split_stack()

	var/stacks_to_take = FLOOR(item_count_current/2, 1)
	if(!stacks_to_take)
		return FALSE


	var/obj/item/I = copy(src)
	I.item_count_current = 0
	src.transfer_item_count_to(I,stacks_to_take)

	return I

/obj/item/click_on_object(var/mob/caller,var/atom/object,location,control,params)

	var/atom/defer_object = object.defer_click_on_object(location,control,params)

	if(try_transfer_reagents(caller,defer_object,location,control,params))
		return TRUE

	if(is_item(defer_object) && src.can_transfer_stacks_to(defer_object))
		var/obj/item/I = defer_object
		var/stacks_transfered = src.transfer_item_count_to(I)
		if(stacks_transfered)
			caller.to_chat("You transfer [stacks_transfered] stacks to \the [I.name].")
		else
			caller.to_chat("\The [I.name] is full!")
		return TRUE

	return ..()

/obj/item/clicked_on_by_object(var/mob/caller,object,location,control,params)

	if(object == src || item_count_current <= 1 || !is_inventory(object) || !is_inventory(src.loc) || get_dist(src,object) > 1)
		return ..()

	var/obj/hud/inventory/I = object
	var/old_item_name = src.name
	var/obj/item/I2 = split_stack()
	caller.to_chat("You split \the stack of [old_item_name]. The new stack now has [I2.item_count_current].")
	I.add_object(I2)
	return TRUE