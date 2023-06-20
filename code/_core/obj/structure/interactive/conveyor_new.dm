/obj/structure/interactive/conveyor
	name = "conveyor belt"
	desc = "A metal conveyor belt, used to move crates and large objects."
	icon = 'icons/obj/structure/conveyor_new.dmi'
	icon_state = "conveyor"

	var/active = TRUE
	var/reversed = FALSE

	plane = PLANE_MOVABLE_DEAD
	layer = LAYER_FLOOR_CONVEYOR

	var/turf/start_turf
	var/turf/end_turf

	density = TRUE
	anchored = TRUE

/obj/structure/interactive/conveyor/clicked_on_by_object(var/mob/caller,var/atom/object,location,control,params)

	INTERACT_CHECK
	INTERACT_CHECK_OBJECT
	INTERACT_DELAY(10)
	if(istype(object,/obj/item))
		var/obj/item/T = object
		if(T.flags_tool & FLAG_TOOL_WRENCH)
			if(anchored)
				caller.to_chat(span("notice","You un-anchor the conveyor."))
				set_anchored(FALSE)
				disable()
			else
				caller.to_chat(span("notice","You anchor the conveyor."))
				set_anchored(TRUE)
				enable()

	if(caller.movement_flags & MOVEMENT_WALKING)
		if(anchored)
			caller.to_chat(span("warning","You need to unsecure \the [src.name] before rotating it!"))
		else
			caller.visible_message(span("notice","\The [caller.name] rotates \the [src.name]."),span("notice","You rotate \the [src.name]."))
			set_dir(turn(dir,90))

		update_conveyor()
		update_sprite()

		for(var/k in DIRECTIONS_CARDINAL)
			var/turf/T = get_step(src,k)
			var/obj/structure/interactive/conveyor/C = locate() in T.contents
			if(C)
				C.update_conveyor()
				C.update_sprite()

		return TRUE

	. = ..()



/obj/structure/interactive/conveyor/Crossed(atom/movable/O,atom/OldLoc)

	if(anchored && active)
		START_THINKING(src)

	. = ..()

/obj/structure/interactive/conveyor/set_anchored(var/desired_anchored=TRUE,var/force=FALSE)
	. = ..()
	if(.)
		if(anchored)
			update_conveyor()
		else
			disable()

/obj/structure/interactive/conveyor/Finalize()
	. = ..()
	if(active)
		enable()
	else
		disable()

/obj/structure/interactive/conveyor/proc/update_conveyor()
	start_turf = get_step(src,turn(dir,180))
	end_turf = get_step(src,dir)
	return TRUE

/obj/structure/interactive/conveyor/update_icon()

	. = ..()

	icon = initial(icon)
	icon_state = initial(icon_state)

	if(anchored)
		var/obj/structure/interactive/conveyor/C = locate() in start_turf
		if(!C || C.dir != dir)
			icon_state = "[icon_state]_start"
		if(active) icon_state = "[icon_state]_on"



/obj/structure/interactive/conveyor/update_overlays()

	. = ..()

	if(anchored)
		var/obj/structure/interactive/conveyor/end_c = locate() in end_turf.contents
		if(!end_c || end_c.dir != dir)
			var/image/I = new/image(initial(icon),"conveyor_end")
			if(active) I.icon_state = "[I.icon_state]_on"
			var/list/pixel_offsets = direction_to_pixel_offset(dir)
			I.pixel_x = pixel_offsets[1]*TILE_SIZE
			I.pixel_y = pixel_offsets[2]*TILE_SIZE
			I.layer = layer + 0.1
			add_overlay(I)


/obj/structure/interactive/conveyor/proc/enable()
	active = TRUE
	START_THINKING(src)
	update_sprite()
	return TRUE

/obj/structure/interactive/conveyor/proc/disable()
	active = FALSE
	STOP_THINKING(src)
	update_sprite()
	return TRUE

/obj/structure/interactive/conveyor/think()

	if(end_turf)
		var/conveyor_limit = 5
		var/moved = FALSE
		for(var/k in loc.contents)
			var/atom/movable/M = k
			if(!is_item(M) && !ismob(M) && !is_structure(M))
				continue
			if(M.collision_flags & FLAG_COLLISION_ETHEREAL)
				continue
			if(conveyor_limit <= 0)
				break
			if(M.anchored)
				continue
			if(M.grabbing_hand || M.next_conveyor > world.time)
				moved = TRUE
				continue
			if(is_living(M))
				var/mob/living/L2 = M
				if(!L2.horizontal && M.next_move > 0)
					moved = TRUE
					continue
			M.glide_size = M.step_size / DECISECONDS_TO_TICKS(16)
			M.Move(end_turf)
			M.next_conveyor = world.time + 16
			conveyor_limit--
			moved = TRUE
			continue
		if(!moved)
			return FALSE


	return TRUE
