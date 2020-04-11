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

	if(is_container) //We're a container being clicked on.
		var/atom/defer_object = object.defer_click_on_object()
		if(is_item(defer_object)) //We're clicking on this item with an object.
			INTERACT_CHECK
			var/obj/item/I = defer_object
			src.add_to_inventory(caller,I) //Add that item in our hands to the container's invetory.
			return TRUE
		if(is_inventory(src.loc) && !is_dynamic_inventory(src.loc))
			INTERACT_CHECK
			click_self(caller) //Open the inventory if we're holding it and we clicked on it with an empty hand.
			return TRUE

	return 	..()


/obj/item/dropped_on_by_object(var/atom/caller,var/atom/object,location,control,params)
	return clicked_on_by_object(caller,object,location,control,params)

/obj/item/drop_on_object(var/atom/caller,var/atom/object,location,control,params) //Src is dragged to object

	if(caller == object)
		return click_self(caller)

	. = ..()

	if(.)
		return .

	if(object.loc && (isturf(object) || isturf(object.loc)))
		caller.face_atom(object)
		var/vel_x = object.x - caller.x
		var/vel_y = object.y - caller.y
		var/highest = max(abs(vel_x),abs(vel_y))

		if(!highest)
			src.drop_item(get_turf(caller))
			return TRUE

		vel_x *= 1/highest
		vel_y *= 1/highest

		vel_x *= 12
		vel_y *= 12

		src.drop_item(get_turf(caller))
		src.throw_self(caller,object,text2num(params[PARAM_ICON_X]),text2num(params[PARAM_ICON_Y]),vel_x,vel_y)
		return TRUE

	return FALSE