/obj/item/proc/can_transfer_stacks_to(var/obj/item/I)
	return istype(src,I)

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

	return N

/obj/item/proc/transfer_stacks_to(var/obj/item/I)
	var/stacks_to_take = clamp(I.item_count_max - I.item_count_current,0,item_count_current)
	if(!stacks_to_take) //We're full!
		return TRUE
	item_count_current -= stacks_to_take
	I.item_count_current += stacks_to_take
	if(item_count_current <= 0)
		qdel(src)
	else
		update_sprite()

	I.update_sprite()

	return stacks_to_take

/obj/item/proc/split_stack()

	var/stacks_to_take = FLOOR(item_count_current/2, 1)
	if(!stacks_to_take)
		return FALSE

	item_count_current -= stacks_to_take
	update_sprite()

	var/obj/item/I = copy(src)
	I.item_count_current = stacks_to_take
	I.update_sprite()

	return I

/obj/item/click_on_object(var/mob/caller,object,location,control,params)

	if(object == src || !is_item(object) || !src.loc || get_dist(src,object) > 1)
		return ..()

	var/obj/item/I = object
	if(I.can_transfer_stacks_to(src))
		var/old_loc_name = I.loc.name
		var/stacks_transfered = I.transfer_stacks_to(src)
		caller.to_chat("You transfer [stacks_transfered] [src.name] from \the [old_loc_name] to \the [src.loc.name].")
		return TRUE

/obj/item/clicked_on_by_object(var/mob/caller,object,location,control,params)

	if(object == src || item_count_current <= 1 || !is_inventory(object) || !is_inventory(src.loc) || get_dist(src,object) > 1)
		return ..()

	var/obj/hud/inventory/I = object
	var/old_item_name = src.name
	var/obj/item/I2 = split_stack()
	caller.to_chat("You split \the stack of [old_item_name]. The new stack now has [I2.item_count_current].")
	I.add_object(I2)
	return TRUE

/*
/obj/item/clicked_on_by_object(var/mob/caller,object,location,control,params)

	if(object == src)
		return ..()

	if(is_inventory(object))
		var/obj/hud/inventory/I = object
		var/obj/item/I = new src.type(get_turf(src))
		I.material_id = material_id
		I.color = color
		I.update_sprite()
		I.transfer_item(I)
		src.item_count_current -= 1
		if(src.item_count_current <= 0)
			qdel(src)
			return TRUE
		update_sprite()
		return TRUE

	if(!istype(object,/obj/item/material/))
		return ..()

	var/obj/item/material/M = object
	if(M.crafting_id != src.crafting_id)
		return ..()

	var/amount_to_transfer = min(M.item_count_max - M.item_count_current,src.item_count_current)

	if(!amount_to_transfer)
		return TRUE

	src.item_count_current -= amount_to_transfer
	M.item_count_current += amount_to_transfer

	caller.to_chat(span("notice","You transfer [amount_to_transfer] sheet\s between the stacks. You now have [M.item_count_current]."))

	M.update_sprite()

	if(src.item_count_current <= 0)
		qdel(src)
		return TRUE

	src.update_sprite()

	return TRUE
*/