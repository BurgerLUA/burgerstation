/obj/item/click_self(caller,location,control,params)

	if(!length(inventories))
		return FALSE

	if(inventory_user && is_advanced(inventory_user))
		var/mob/living/advanced/A = inventory_user
		for(var/obj/hud/button/close_inventory/B in A.buttons)
			B.alpha = 0
			B.mouse_opacity = 0

	var/mob/living/advanced/A = caller
	var/turf/T = get_turf(src)
	var/area/A2 = get_area(T)

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
			I.screen_loc = "CENTER+[-MAX_INVENTORY_X*0.5 + i - 0.5 - floor((i-1)/MAX_INVENTORY_X)*MAX_INVENTORY_X],BOTTOM+[1.25 + floor((i-1)/MAX_INVENTORY_X)]"

		if(opening || !I.alpha)
			animate(I,alpha=255,time=4)
			I.mouse_opacity = 2
			opening = TRUE
		else
			animate(I,alpha=0,time=4)
			I.mouse_opacity = 0
			opening = FALSE

	if(opening)
		play_sound(pick(inventory_sounds),all_mobs_with_clients,vector(T.x,T.y,T.z),environment = A2.sound_environment, channel = SOUND_CHANNEL_FX)

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

	if(is_container)

		if(is_inventory(src.loc) && !is_dynamic_inventory(src.loc) && is_inventory(object) && is_advanced(caller) && length(inventories) && get_dist(caller,src) <= 1 && click_self(caller,location,control,params)) //Open the inventory
			return TRUE

		if(is_inventory(object))
			src.transfer_item(object)
			return TRUE

		if(is_item(object)) //Add to the inventory
			add_to_inventory(caller,object,TRUE)
			return TRUE

	return 	..()

/obj/item/drop_on_object(var/atom/caller,var/atom/object) //Src is dragged to object

	if(caller == object)
		return click_self(caller)

	return ..()

/obj/item/dropped_on_by_object(var/atom/caller,var/atom/object) //Object is dragged to src

	if(is_item(object))
		object.click_on_object(caller,src)
		return TRUE

	return ..()
