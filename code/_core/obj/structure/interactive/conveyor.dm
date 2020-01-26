/obj/structure/interactive/conveyor
	name = "conveyor belt"
	icon = 'icons/obj/structure/conveyor.dmi'
	icon_state = "conveyor"

	var/active = TRUE
	var/reversed = FALSE

	layer = LAYER_GROUND_SCENERY

/obj/structure/interactive/conveyor/shuttle
	plane = PLANE_SHUTTLE

/obj/structure/interactive/conveyor/shuttle/inverted
	icon_state = "conveyor_inverted"
	reversed = TRUE

/obj/structure/interactive/conveyor/inverted
	icon_state = "conveyor_inverted"
	reversed = TRUE

/obj/structure/interactive/conveyor/Initialize()

	if(active)
		enable()
	else
		update_icon()

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

	world.log << "The state is: [icon_state]."

	return ..()

/obj/structure/interactive/conveyor/proc/enable()
	active = TRUE
	start_thinking(src)
	update_icon()
	return TRUE

/obj/structure/interactive/conveyor/proc/disable()
	active = FALSE
	stop_thinking(src)
	update_icon()
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

	var/turf/desired_turf = get_step(src,desired_dir)

	if(desired_turf)
		var/obj/structure/interactive/conveyor/C = locate() in desired_turf.contents
		if(C)
			for(var/atom/movable/M in desired_turf.contents)
				if(M.anchored || M.grabbing_hand)
					continue
				return TRUE

		for(var/atom/movable/M in loc.contents)
			if(M.anchored || M.next_conveyor > curtime || M.move_delay > (is_living(M) ? -1 : 0) || M.grabbing_hand)
				continue
			M.glide_size = M.step_size / DECISECONDS_TO_TICKS(8)
			M.Move(desired_turf,silent=TRUE)
			M.next_conveyor = curtime + 8
			break

	return TRUE