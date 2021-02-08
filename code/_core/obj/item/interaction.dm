/obj/item/click_self(var/mob/caller,location,control,params)

	INTERACT_CHECK
	INTERACT_DELAY(5)

	if(!length(inventories))
		return FALSE

	if(inventory_user)
		var/mob/living/advanced/A = inventory_user
		for(var/obj/hud/button/close_inventory/B in A.buttons)
			B.alpha = 0
			B.mouse_opacity = 0

	var/mob/living/advanced/A = caller

	var/opening = FALSE
	var/should_center = length(inventories) <= MAX_INVENTORY_X

	for(var/k in A.inventory)
		var/obj/hud/inventory/I = k
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
		play_sound(pick(inventory_sounds),get_turf(src),range_max=VIEW_RANGE*0.25)

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

	inventory_user = caller

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

	return 	..()


/obj/item/dropped_on_by_object(var/mob/caller,var/atom/object,location,control,params)
	return clicked_on_by_object(caller,object,location,control,params)

/obj/item/drop_on_object(var/mob/caller,var/atom/object,location,control,params) //Src is dragged to object

	if(!can_be_dragged(caller))
		return TRUE

	if(isturf(object) || istype(object,/obj/structure/smooth/table))
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

	return ..()

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

