/obj/item/proc/can_transfer_stacks_to(var/obj/item/target) //General all-purpose code.

	if(target == src)
		return FALSE

	if(target.amount_max <= 1 || src.amount_max <= 1)
		return FALSE

	if(!istype(target,src) && !istype(src,target))
		return FALSE

	if(target.amount >= target.amount_max)
		return FALSE

	return TRUE

/obj/item/proc/transfer_amount_to(var/obj/item/target,var/amount_to_transfer = amount)
	if(!amount_to_transfer) return 0
	if(amount_to_transfer < 0)
		return target.transfer_amount_to(src,-amount_to_transfer)
	amount_to_transfer = min(
		amount_to_transfer, //What we want to transfer
		amount, //What we can actually transfer from
		target.amount_max - target.amount //What the target can actually hold.
	)

	var/reagents_ratio = amount_to_transfer / amount

	target.add_item_count(amount_to_transfer,TRUE)
	if(src.reagents && target.reagents)
		src.reagents.transfer_reagents_to(target.reagents,src.reagents.volume_current*reagents_ratio)
	src.add_item_count(-amount_to_transfer,TRUE)

	return amount_to_transfer


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
		if(I.loc && is_inventory(I.loc))
			//Transfering src to what we clicked on (what we clicked on is inside an inventory).
			if(src.can_transfer_stacks_to(I)) //We add to it.
				INTERACT_CHECK
				INTERACT_CHECK_OBJECT
				INTERACT_DELAY(1)
				var/stacks_transfered = src.transfer_amount_to(I)
				if(stacks_transfered)
					caller.to_chat(span("notice","You transfer [stacks_transfered] stacks to \the [I.name]."))
				else
					caller.to_chat(span("warning","You can't transfer any more stacks to \the [I.name], it's full!"))
				return TRUE
		else
			//Transfering what we clicked on to src.
			if(I.can_transfer_stacks_to(src)) //We can take from it.
				INTERACT_CHECK
				INTERACT_CHECK_OBJECT
				INTERACT_DELAY(1)

				var/atom/old_location = I.loc

				var/stacks_transfered = I.transfer_amount_to(src)

				if(src.amount < src.amount_max && is_turf(old_location))
					var/turf/T = old_location
					var/check_limit = 10
					for(var/obj/item/O in old_location)
						if(check_limit <= 0 || src.amount >= src.amount_max)
							break
						check_limit--
						if(O == I)
							continue
						if(O.loc != T || O.qdeleting)
							continue
						if(!O.can_transfer_stacks_to(src))
							continue
						stacks_transfered += O.transfer_amount_to(src)

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
				new_stack.amount = 0
				INITIALIZE(new_stack)
				FINALIZE(new_stack)
				new_stack.force_move(get_turf(src))
				src.transfer_amount_to(new_stack,splitamount)
				I.add_object(new_stack)
				caller.to_chat(span("notice","You split \the stack of [old_item_name]. The new stack now has [new_stack.amount]."))
	return TRUE