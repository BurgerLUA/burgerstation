/obj/item/click_on_object(var/mob/caller,var/atom/object,location,control,params)

	if(is_container)
		var/turf/found_turf
		if(is_turf(object))
			found_turf = object
		else if(is_turf(object.loc))
			if(is_item(object))
				if(..() || object.clicked_on_by_object(caller,src,location,control,params))
					return TRUE
			found_turf = object.loc
		if(found_turf)
			INTERACT_CHECK
			INTERACT_CHECK_OBJECT
			INTERACT_DELAY(10)
			var/result = FALSE
			var/found_object = FALSE
			for(var/obj/item/I in found_turf.contents)
				found_object = TRUE
				if(!src.add_object_to_src_inventory(caller,I,enable_messages=FALSE,bypass=FALSE,silent=TRUE))
					continue
				result = TRUE
			if(result)
				caller.to_chat(span("notice","You shove everything you can into \the [src.name]."))
			else
				if(!found_object)
					caller.to_chat(span("notice","There is nothing on \the [found_turf.name] to add to \the [src.name]."))
				else
					caller.to_chat(span("notice","You can't seem to fit anything on the [found_turf.name] to \the [src.name]."))
			return TRUE

	. = ..()

/obj/item/clicked_on_by_object(var/mob/caller as mob,var/atom/object,location,control,params) //The src was clicked on by the object

	if(caller.attack_flags & CONTROL_MOD_DISARM)
		return src.click_self(caller,location,control,params)

	if(is_inventory(object) && additional_clothing_parent)
		INTERACT_CHECK
		INTERACT_CHECK_OBJECT
		INTERACT_DELAY(1)
		src.drop_item(additional_clothing_parent,silent=TRUE)
		return TRUE

	if(is_container && is_item(object)) //We're a container being clicked on by an item.
		INTERACT_CHECK
		INTERACT_CHECK_OBJECT
		var/obj/item/I = object
		if(src.add_object_to_src_inventory(caller,I))
			INTERACT_DELAY(1)
			return TRUE

	. = ..()


/obj/item/click_self(var/mob/caller,location,control,params)

	if(!length(inventories))
		return FALSE

	if(!is_advanced(caller))
		return FALSE

	if(can_interact_with_inventory(caller))
		INTERACT_CHECK
		INTERACT_DELAY(1)
		if(caller == inventory_user)
			close_inventory(inventory_user)
		else
			open_inventory(caller)
		return TRUE

	return FALSE


/obj/item/proc/can_interact_with_inventory(var/mob/living/advanced/caller)

	if(inventory_user && inventory_user != caller)
		caller.to_chat(span("warning","\The [inventory_user.name] is using \the [src.name]!"))
		return FALSE

	return TRUE

/obj/item/proc/open_inventory(var/mob/living/advanced/A)

	if(loot_to_generate)
		var/rarity = 0
		if(is_player(A))
			var/mob/living/advanced/player/P = A
			rarity = P.get_rarity()
		var/list/generated_loot = SPAWN_LOOT(loot_to_generate,get_turf(src),rarity)
		for(var/k in generated_loot)
			var/atom/movable/M = k
			if(!src.add_object_to_src_inventory(null,M,enable_messages=FALSE,bypass=FALSE,silent=TRUE))
				qdel(M)
		A.to_chat(span("notice","You [loot_open_verb] \the [src.name]."))
		loot_to_generate = null

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
		if(i==1)
			if(!I.assoc_button)
				I.assoc_button = new /obj/hud/button/close_inventory
				I.assoc_button.assoc_item = src
			if(should_center)
				I.assoc_button.screen_loc = "CENTER+[(length(inventories)+1)/2],[starting_inventory_y]"
			else
				I.assoc_button.screen_loc = "CENTER+[0.5+max_inventory_x*0.5],[starting_inventory_y]"
			I.assoc_button.update_owner(A)
			I.assoc_button.alpha = 0
			I.assoc_button.mouse_opacity = 1

			animate(I.assoc_button,alpha=255,time=4)
		if(should_center)
			I.screen_loc = "CENTER+[i]-[(length(inventories)+1)/2],[starting_inventory_y]"
		else
			I.screen_loc = "CENTER+[-max_inventory_x*0.5 + i - 0.5 - FLOOR((i-1)/max_inventory_x, 1)*max_inventory_x],[starting_inventory_y]+[FLOOR((i-1)/max_inventory_x, 1)*inventory_y_multiplier]"
		I.alpha = 0
		I.update_owner(A)
		var/initial_mouse = initial(I.mouse_opacity)
		I.mouse_opacity = initial_mouse ? initial_mouse : 1
		animate(I,alpha=255,time=4)

	play_sound(pick(inventory_sounds),get_turf(src),range_max=VIEW_RANGE*0.25)
	inventory_user = A
	inventory_user.using_inventories += src

	return TRUE

/obj/item/proc/close_inventory(var/mob/living/advanced/A)

	if(inventory_user)
		inventory_user.using_inventories -= src
		inventory_user = null

	for(var/i=1,i<=length(inventories),i++) //Close all the inventories.
		var/obj/hud/inventory/I = inventories[i]
		if(I.assoc_button)
			animate(I.assoc_button,alpha=0,time=4)
			I.assoc_button.mouse_opacity = 0
		animate(I,alpha=0,time=4)
		I.mouse_opacity = 0

	return TRUE

/obj/item/drop_on_object(var/mob/caller,var/atom/object,location,control,params) //Src is dragged to object

	if(!can_be_dragged(caller))
		return TRUE

	if(is_inventory(object.loc) && object.loc.dropped_on_by_object(caller,src,location,control,params))
		return TRUE

	if(is_floor(object) || istype(object,/obj/structure/table))
		INTERACT_CHECK
		INTERACT_CHECK_OBJECT
		var/turf/T = get_turf(object)
		if(is_container && can_dump_contents(caller,T))
			INTERACT_DELAY(10)
			PROGRESS_BAR(caller,src,SECONDS_TO_DECISECONDS(3),src::dump_contents(),caller,T)
			PROGRESS_BAR_CONDITIONS(caller,src,src::can_dump_contents(),caller,T)
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
		if(is_turf(new_location))
			play_sound(drop_sound,new_location,range_max=VIEW_RANGE*0.5)
		else
			play_sound(inventory_sound,get_turf(new_location),range_max=VIEW_RANGE*0.25,volume=25)

	if(is_inventory(src.loc))
		var/obj/hud/inventory/I = src.loc
		if(!new_location)
			new_location = get_turf(I.owner)
		return I.remove_object(src,new_location,pixel_x_offset,pixel_y_offset,silent)

	force_move(new_location)

	return TRUE

