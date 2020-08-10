/obj/structure/interactive/conveyor
	name = "conveyor belt"
	desc = "A metal conveyor belt, used to move crates and large objects"
	icon = 'icons/obj/structure/conveyor.dmi'
	icon_state = "conveyor"

	var/active = TRUE
	var/reversed = FALSE

	layer = LAYER_GROUND_CONVERYOR

/obj/structure/interactive/conveyor/shuttle
	plane = PLANE_SHUTTLE

/obj/structure/interactive/conveyor/shuttle/inverted
	icon_state = "conveyor_inverted"
	reversed = TRUE

/obj/structure/interactive/conveyor/inverted
	icon_state = "conveyor_inverted"
	reversed = TRUE

/obj/structure/interactive/conveyor/PostInitialize()

	if(active)
		enable()
	else
		disable()

	return ..()

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

	var/desired_dir = dir

	if(reversed)
		desired_dir = turn(desired_dir,180)
		if(desired_dir in DIRECTIONS_INTERCARDINAL)
			desired_dir = turn(desired_dir,45)
	else
		if(desired_dir in DIRECTIONS_INTERCARDINAL)
			desired_dir = turn(desired_dir,-45)

	var/turf/desired_turf = get_step(src,desired_dir) //The turf where we're going

	var/obj/structure/interactive/limiter/L = locate() in desired_turf.contents

	if(L)
		var/obj/item/I = locate() in desired_turf.contents
		if(I)
			return TRUE

	if(desired_turf)
		var/conveyor_limit = 5
		for(var/k in loc.contents)
			var/atom/movable/M = k
			if(M.collision_flags & FLAG_COLLISION_ETHEREAL)
				continue
			if(conveyor_limit <= 0)
				break
			if(M.anchored || M.grabbing_hand || M.next_conveyor > world.time)
				continue
			if(is_living(M))
				var/mob/living/L2 = M
				if(!L2.horizontal && M.move_delay > -1)
					continue
			M.glide_size = M.step_size / DECISECONDS_TO_TICKS(8)
			M.Move(desired_turf,silent=TRUE)
			M.next_conveyor = world.time + 8
			conveyor_limit--
			break

	return TRUE