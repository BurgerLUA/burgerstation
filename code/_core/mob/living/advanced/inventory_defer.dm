/mob/living/advanced/proc/clear_inventory_defers()

	for(var/k in inventory_defers)
		var/obj/hud/button/inventory_defer/ID = k
		ID.update_owner(null)

	return TRUE

/mob/living/advanced/proc/add_inventory_defer(var/obj/hud/inventory/I,var/slot=0)

	var/x_pos = (slot % 6) - 3
	var/y_pos = -FLOOR(1 + slot/6,1)

	var/obj/hud/button/inventory_defer/B = new
	B.icon = initial(I.icon)
	B.icon_state = initial(I.icon_state)
	B.screen_loc = "CENTER+[x_pos],TOP+[y_pos]"
	B.clone(I)
	B.update_owner(src)

	if(slot==0)
		var/obj/hud/button/close_inventory_defers/C = new
		C.screen_loc = "CENTER+[x_pos+6],TOP+[y_pos]"
		C.update_owner(src)
		B.assoc_button = C

	return B

/mob/living/advanced/proc/examine_body_inventory(var/mob/living/advanced/caller) //caller wants to see inside src

	if(!src.can_caller_interact_with(caller,distance_checks=FALSE))
		return TRUE

	INTERACT_DELAY(10)

	if(!(caller in viewers(VIEW_RANGE,src)))
		return TRUE

	src.clear_inventory_defers() //Remove existing ones.

	var/s=0

	for(var/k in src.inventory)
		var/obj/hud/inventory/I = k
		if(!(I.flags & (FLAGS_HUD_INVENTORY | FLAGS_HUD_MOB)))
			continue
		if(I.flags & FLAGS_HUD_CONTAINER) //Organs only.
			continue
		caller.add_inventory_defer(I,s)
		s++

	return TRUE