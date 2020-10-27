/obj/structure/interactive/conveyor
	name = "conveyor belt"
	desc = "A metal conveyor belt, used to move crates and large objects"
	icon = 'icons/obj/structure/conveyor.dmi'
	icon_state = "conveyor"

	var/active = TRUE
	var/reversed = FALSE

	layer = LAYER_FLOOR_CONVEYOR

	var/obj/structure/interactive/limiter/found_limiter
	var/turf/move_turf

	density = TRUE



/obj/structure/interactive/conveyor/shuttle
	plane = PLANE_SHUTTLE

/obj/structure/interactive/conveyor/shuttle/inverted
	icon_state = "conveyor_inverted"
	reversed = TRUE

/obj/structure/interactive/conveyor/inverted
	icon_state = "conveyor_inverted"
	reversed = TRUE

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

	var/move_direction = dir

	var/list/optimization = list(
		"[NORTHEAST]" = TRUE,
		"[NORTHWEST]" = TRUE,
		"[SOUTHWEST]" = TRUE,
		"[SOUTHEAST]" = TRUE
	)

	var/intercardinal = optimization["[move_direction]"]

	if(reversed)
		move_direction = turn(move_direction,180)
		if(intercardinal)
			move_direction = turn(move_direction,45)
	else if(intercardinal)
		move_direction = turn(move_direction,-45)

	move_turf = get_step(src,move_direction)
	found_limiter = locate() in move_turf.contents

	return TRUE


/obj/structure/interactive/conveyor/update_icon()

	icon = initial(icon)
	icon_state = "conveyor"

	if(active)
		if(reversed)
			icon_state = "[icon_state]_inverted"
		icon_state = "[icon_state]_on"
	else
		icon_state = "[icon_state]_off"

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
			M.glide_size = M.step_size / DECISECONDS_TO_TICKS(8)
			M.Move(move_turf)
			M.next_conveyor = world.time + 8
			conveyor_limit--
			moved = TRUE
			continue
		if(!moved)
			return FALSE


	return TRUE