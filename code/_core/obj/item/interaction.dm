/obj/item/click_self(caller,location,control,params)

	if(!length(inventories))
		return FALSE

	if(inventory_user && is_advanced(inventory_user))
		var/mob/living/advanced/A = inventory_user
		for(var/obj/hud/button/close_inventory/B in A.buttons)
			B.alpha = 0
			B.mouse_opacity = 0

	var/mob/living/advanced/A = caller

	var/opening = FALSE
	var/should_center = length(inventories) <= MAX_INVENTORY_X

	for(var/obj/hud/inventory/I in A.inventory)
		CHECK_TICK(100,FPS_SERVER*0.5)
		if(I in inventories)
			continue
		if(!(I.flags & FLAGS_HUD_CONTAINER))
			continue
		I.alpha = 0
		I.mouse_opacity = 0

	if(inventory_user != A)
		for(var/obj/hud/button/close_inventory/B in A.buttons)
			B.alpha = 0
			B.mouse_opacity = 0

	for(var/i=1,i<=length(inventories),i++)
		CHECK_TICK(100,FPS_SERVER*0.5)
		var/obj/hud/inventory/I = inventories[i]
		I.update_owner(A)

		if(should_center)
			I.screen_loc = "CENTER+[i]-[(length(inventories)+1)/2],BOTTOM+1.25"
		else
			I.screen_loc = "CENTER+[-MAX_INVENTORY_X*0.5 + i - 0.5 - FLOOR((i-1)/MAX_INVENTORY_X, 1)*MAX_INVENTORY_X],BOTTOM+[1.25 + FLOOR((i-1)/MAX_INVENTORY_X, 1)]"

		if(opening || !I.alpha)
			animate(I,alpha=255,time=4)
			I.mouse_opacity = 2
			opening = TRUE
		else
			animate(I,alpha=0,time=4)
			I.mouse_opacity = 0
			opening = FALSE

	if(opening)
		play(pick(inventory_sounds),src)

	for(var/obj/hud/button/close_inventory/B in A.buttons)

		if(should_center)
			B.screen_loc = "CENTER+[(length(inventories)+1)/2],BOTTOM+1.25"
		else
			B.screen_loc = "CENTER+[0.5+MAX_INVENTORY_X*0.5],BOTTOM+1.25"

		if(opening)
			animate(B,alpha=255,time=4)
			B.mouse_opacity = 2
		else
			animate(B,alpha=0,time=4)
			B.mouse_opacity = 0

		break

	inventory_user = caller

	return TRUE


/obj/item/clicked_on_by_object(var/mob/caller as mob,var/atom/object,location,control,params) //The src was clicked on by the object

	if(additional_clothing_parent)
		drop_item(additional_clothing_parent)
		return TRUE

	if(is_container) //We're a container being clicked on.
		var/atom/defer_object = object.defer_click_on_object(location,control,params)
		if(is_item(defer_object)) //We're clicking on this item with an object.
			INTERACT_CHECK
			var/obj/item/I = defer_object
			src.add_to_inventory(caller,I) //Add that item in our hands to the container's invetory.
			return TRUE

	return 	..()


/obj/item/dropped_on_by_object(var/atom/caller,var/atom/object,location,control,params)
	return clicked_on_by_object(caller,object,location,control,params)

/obj/item/drop_on_object(var/atom/caller,var/atom/object,location,control,params) //Src is dragged to object

	if(!can_be_dragged(caller))
		return TRUE

	if(caller == object)
		return click_self(caller)

	return ..()

/obj/item/proc/can_be_dragged(var/mob/caller)

	if(additional_clothing_parent)
		return FALSE

	return TRUE