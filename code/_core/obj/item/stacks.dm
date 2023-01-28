/obj/item/proc/can_transfer_stacks_to(var/obj/item/I)
	return (istype(I,src) || istype(src,I)) && I != src && I.amount_max > 1

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
			"vars",
			"vis_locs",
			"vis_contents",
			"initialized",
			"finalized",
			"generated"
		)
	)

	var/atom/movable/N = new A.type(A.loc)

	for(var/i in A.vars)
		if(denyvar[i])
			continue
		try
			if(islist(A.vars[i])) //Don't copy lists.
				continue
			if(is_datum(A.vars[i])) //Turn datums into a path if appropriate.
				var/datum/D = A.vars[i]
				if(ispath(N.vars[i]))
					N.vars[i] = D.type
				continue
			N.vars[i] = A.vars[i]
		catch()
			log_error("copy() error: Cannot write var [i] for type [A.type]!")

	N.loc = null

	return N

/obj/item/click_on_object(var/mob/caller,var/atom/object,location,control,params)

	if(try_transfer_reagents(caller,object,location,control,params))
		return TRUE

	if(is_item(object))
		var/obj/item/I = object
		if(I.can_transfer_stacks_to(src))
			INTERACT_CHECK
			INTERACT_CHECK_OBJECT
			INTERACT_DELAY(1)
			var/stacks_transfered = I.transfer_amount_to(src)
			if(stacks_transfered)
				caller.to_chat(span("notice","You transfer [stacks_transfered] stacks to \the [src.name]."))
			else
				caller.to_chat(span("warning","You can't transfer any more stacks to \the [src.name], it's full!"))
			return TRUE

	return ..()

/obj/item/clicked_on_by_object(var/mob/caller,var/atom/object,location,control,params)

	if(object == src || amount <= 1 || !is_inventory(object) || !is_inventory(src.loc) || get_dist(src,object) > 1)
		return ..()

	INTERACT_CHECK
	INTERACT_CHECK_OBJECT
	INTERACT_DELAY(1)
	if(is_living(caller))
		var/mob/living/L = caller
		if(amount > 1 && CONTROL_MOD_DISARM && amount_max > 1)
			var/choice = input("How much do you want to put in your other hand?","Amount to split",0) as num
			var/splitamount = FLOOR(choice,1)
			if(!choice || splitamount <= 0 || splitamount >= amount)
				L.to_chat(span("notice","You decide not to split the stack."))
			else if (amount > 1) //just in case.
				var/obj/hud/inventory/I = object
				var/old_item_name = src.name
				var/obj/item/new_stack = copy(src)
				var/reagents_ratio = splitamount / amount
				INITIALIZE(new_stack)
				FINALIZE(new_stack)
				new_stack.amount = 0
				new_stack.force_move(get_turf(src))
				src.transfer_amount_to(new_stack,splitamount)
				I.add_object(new_stack)
				if(reagents && new_stack.reagents)
					reagents.transfer_reagents_to(new_stack.reagents,new_stack.reagents.volume_current*reagents_ratio)
				caller.to_chat(span("notice","You split \the stack of [old_item_name]. The new stack now has [new_stack.amount]."))
	return TRUE