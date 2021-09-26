/obj/item/click_self(var/mob/caller,location,control,params)

	if(!length(inventories))
		return FALSE

	if(!is_advanced(caller))
		return FALSE

	if(can_interact_with_inventory(caller))
		if(caller == inventory_user)
			close_inventory(inventory_user)
		else
			open_inventory(caller)
		return TRUE

	return FALSE


/obj/item/proc/can_interact_with_inventory(var/mob/living/advanced/caller)

	INTERACT_CHECK
	INTERACT_DELAY(5)

	if(inventory_user && inventory_user != caller)
		caller.to_chat(span("warning","\The [inventory_user.name] is using \the [src.name]!"))
		return FALSE

	return TRUE

/obj/item/proc/close_inventory(var/mob/living/advanced/A)

	if(inventory_user)
		for(var/obj/hud/button/close_inventory/B in inventory_user.buttons)
			B.update_owner(null)
		inventory_user.using_inventories -= src
		inventory_user = null


	for(var/i=1,i<=length(inventories),i++) //Close all the inventories.
		var/obj/hud/inventory/I = inventories[i]
		animate(I,alpha=0,time=4)
		I.mouse_opacity = 0

	if(A)
		for(var/obj/hud/button/close_inventory/B in A.buttons)
			B.update_owner(null)

	return TRUE

/obj/item/proc/open_inventory(var/mob/living/advanced/A)

	if(inventory_user)
		close_inventory(inventory_user)

	for(var/k in A.using_inventories)
		var/obj/item/I = k
		if(I == src)
			continue
		if(I.inventory_category != inventory_category)
			continue
		I.close_inventory(A)

	var/should_center = length(inventories) <= max_inventory_x

	for(var/i=1,i<=length(inventories),i++) //Open all the inventories.
		var/obj/hud/inventory/I = inventories[i]
		I.update_owner(A)
		if(should_center)
			I.screen_loc = "CENTER+[i]-[(length(inventories)+1)/2],[starting_inventory_y]"
		else
			I.screen_loc = "CENTER+[-max_inventory_x*0.5 + i - 0.5 - FLOOR((i-1)/max_inventory_x, 1)*max_inventory_x],[starting_inventory_y]+[FLOOR((i-1)/max_inventory_x, 1)*inventory_y_multiplier]"
		I.mouse_opacity = 2
		animate(I,alpha=255,time=4)

	var/obj/hud/button/close_inventory/B = new
	B.inventory_category = inventory_category
	B.update_owner(A)
	if(should_center)
		B.screen_loc = "CENTER+[(length(inventories)+1)/2],[starting_inventory_y]"
	else
		B.screen_loc = "CENTER+[0.5+max_inventory_x*0.5],[starting_inventory_y]"
	B.alpha = 0
	B.mouse_opacity = 1
	animate(B,alpha=255,time=4)

	play_sound(pick(inventory_sounds),get_turf(src),range_max=VIEW_RANGE*0.25)
	inventory_user = A
	inventory_user.using_inventories |= src

	return TRUE

/obj/item/clicked_on_by_object(var/mob/caller as mob,var/atom/object,location,control,params) //The src was clicked on by the object

	if(is_inventory(object) && additional_clothing_parent)
		INTERACT_CHECK
		INTERACT_CHECK_OBJECT
		INTERACT_DELAY(1)
		drop_item(additional_clothing_parent,silent=TRUE)
		return TRUE

	if(is_container && is_item(object)) //We're a container being clicked on.
		INTERACT_CHECK
		INTERACT_CHECK_OBJECT
		var/obj/item/I = object
		src.add_to_inventory(caller,I) //Add that item in our hands to the container's inventory.
		return TRUE

	. = ..()

/obj/item/drop_on_object(var/mob/caller,var/atom/object,location,control,params) //Src is dragged to object

	if(!can_be_dragged(caller))
		return TRUE

	if(is_inventory(object.loc) && object.loc.dropped_on_by_object(caller,src,location,control,params))
		return TRUE

	if(is_floor(object) || istype(object,/obj/structure/smooth/table))
		INTERACT_CHECK
		INTERACT_CHECK_OBJECT
		var/turf/T = get_turf(object)
		if(is_container && can_dump_contents(caller,T))
			INTERACT_DELAY(10)
			PROGRESS_BAR(caller,src,SECONDS_TO_DECISECONDS(3),.proc/dump_contents,caller,T)
			PROGRESS_BAR_CONDITIONS(caller,src,.proc/can_dump_contents,caller,T)
			caller.visible_message(span("notice","\The [caller.name] starts to empty the contents of \the [src.name]..."),span("notice","You start to empty the contents of \the [src.name] onto \the [object.name]..."))
		else
			INTERACT_DELAY(1)
			src.drop_item(T)
		return TRUE

	if(caller == object)
		return click_self(caller)

	. = ..()

/obj/item/proc/can_be_dragged(var/mob/caller)
	if(additional_clothing_parent)
		return FALSE
	return TRUE


/obj/item/proc/dump_single_content(var/mob/caller,var/obj/item/I,var/turf/target_turf)

	if(!caller || !target_turf || !I)
		return FALSE

	if(get_dist(caller,target_turf) > 1)
		return FALSE

	if(!is_inventory(I.loc))
		return FALSE

	if(I.loc.loc != src)
		return FALSE

	I.drop_item(target_turf,rand(-8,8),rand(-8,8),silent=TRUE)

	return TRUE

/obj/item/proc/can_dump_contents(var/mob/caller,var/turf/target_turf)

	INTERACT_CHECK_NO_DELAY(src)
	INTERACT_CHECK_NO_DELAY(target_turf)

	return TRUE


/obj/item/proc/dump_contents(var/mob/caller,var/turf/target_turf)

	for(var/k in inventories)
		var/obj/hud/inventory/I = k
		for(var/i in I.contents)
			CHECK_TICK(50,FPS_SERVER)
			var/obj/item/I2 = i
			if(!dump_single_content(caller,I2,target_turf))
				break

	caller.visible_message(span("notice","\The [caller.name] dumps out the contents of \the [src.name] onto \the [target_turf.name]."),span("notice","You dump out the contents of \the [src.name] onto \the [target_turf.name]."))

	return TRUE


/obj/item/proc/drop_item(var/atom/new_location,var/pixel_x_offset = 0,var/pixel_y_offset = 0,var/silent=FALSE) //Should be used in place of forcemove when possible.

	if(drop_sound && !silent && new_location && !qdeleting)
		if(isturf(new_location))
			play_sound(drop_sound,new_location,range_max=VIEW_RANGE*0.5)
		else
			play_sound(inventory_sound,get_turf(new_location),range_max=VIEW_RANGE*0.25,volume=25)

	if(is_inventory(src.loc))
		var/obj/hud/inventory/I = src.loc
		if(!new_location)
			new_location = get_turf(I.owner)
		if(I.remove_object(src,new_location,pixel_x_offset,pixel_y_offset,silent))
			return TRUE
		else
			return FALSE

	force_move(new_location)

	return TRUE

