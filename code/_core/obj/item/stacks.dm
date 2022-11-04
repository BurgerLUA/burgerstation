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
			"vis_contents"
		)
	)

	var/atom/movable/N = new A.type(A.loc)

	for(var/i in A.vars)
		if(denyvar[i])
			continue
		try
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
			if(!choice || FLOOR(choice,1) <= 0)
				L.to_chat(span("notice","You decide not to split the stack."))
			else
				var/obj/hud/inventory/I = object
				var/old_item_name = src.name
				var/obj/item/stack2
				if(choice >= amount)
					var/to_transfer = FLOOR((amount - 1),1)
					stack2 = copy(src)
					stack2.force_move(get_turf(src))
					stack2.amount = 0
					src.transfer_amount_to(stack2,to_transfer)
				else
					var/to_transfer = FLOOR(choice,1)
					stack2 = copy(src)
					stack2.force_move(get_turf(src))
					stack2.amount = 0
					src.transfer_amount_to(stack2,to_transfer)
				I.add_object(stack2)
				caller.to_chat(span("notice","You split \the stack of [old_item_name]. The new stack now has [stack2.amount]."))
	return TRUE