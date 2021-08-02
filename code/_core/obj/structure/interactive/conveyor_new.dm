/obj/structure/interactive/conveyor
	name = "conveyor belt"
	desc = "A metal conveyor belt, used to move crates and large objects"
	icon = 'icons/obj/structure/conveyor_new.dmi'
	icon_state = "conveyor"

	var/active = TRUE
	var/reversed = FALSE

	layer = LAYER_FLOOR_CONVEYOR

	var/obj/structure/interactive/limiter/found_limiter
	var/turf/move_turf

	density = TRUE

/obj/structure/interactive/conveyor/clicked_on_by_object(var/mob/caller,var/atom/object,location,control,params)

	INTERACT_CHECK
	INTERACT_CHECK_OBJECT
	INTERACT_DELAY(10)

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

/obj/structure/interactive/conveyor/Crossed(atom/movable/O)
	start_thinking(src)
	return ..()

/obj/structure/interactive/conveyor/post_move()
	update_conveyor()
	return ..()

/obj/structure/interactive/conveyor/PostInitialize()

	if(active)
		enable()
	else
		disable()

	update_conveyor()

	return ..()

/obj/structure/interactive/conveyor/proc/update_conveyor()
	move_turf = get_step(src,dir)
	found_limiter = locate() in move_turf.contents
	return TRUE


/obj/structure/interactive/conveyor/update_icon()

	icon = initial(icon)
	icon_state = "conveyor"

	var/turf/start_turf = get_step(src,turn(dir,180))
	var/obj/structure/interactive/conveyor/start_c = locate() in start_turf.contents

	if(!start_c || start_c.dir != dir)
		icon_state = "conveyor_start"

	if(active) icon_state = "[icon_state]_on"

	return ..()

/obj/structure/interactive/conveyor/update_overlays()

	var/turf/end_turf = get_step(src,dir)
	var/obj/structure/interactive/conveyor/end_c = locate() in end_turf.contents

	if(!end_c || end_c.dir != dir)
		var/image/I = new/image(initial(icon),"conveyor_end")
		if(active) I.icon_state = "[I.icon_state]_on"
		var/list/pixel_offsets = direction_to_pixel_offset(dir)
		I.pixel_x = pixel_offsets[1]*TILE_SIZE
		I.pixel_y = pixel_offsets[2]*TILE_SIZE
		I.layer = layer + 0.1
		add_overlay(I)

	return ..()

/obj/structure/interactive/conveyor/proc/enable()
	active = TRUE
	start_thinking(src)
	update_sprite()
	return TRUE

/obj/structure/interactive/conveyor/proc/disable()
	active = FALSE
	stop_thinking(src)
	update_sprite()
	return TRUE

/obj/structure/interactive/conveyor/think()

	if(found_limiter)
		var/obj/item/I = locate() in move_turf.contents
		if(I) return TRUE

	if(move_turf)
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
				if(!L2.horizontal && M.move_delay > -1)
					moved = TRUE
					continue
			M.glide_size = M.step_size / DECISECONDS_TO_TICKS(16)
			M.Move(move_turf)
			M.next_conveyor = world.time + 16
			conveyor_limit--
			moved = TRUE
			continue
		if(!moved)
			return FALSE


	return TRUE
