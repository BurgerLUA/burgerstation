#define SHUTTLE_STATUS_NONE "none"

#define SHUTTLE_STATE_LAUNCHING "launching" //We're going to launch.
#define SHUTTLE_STATE_TRANSIT "transit" //We're currently in transit.
#define SHUTTLE_STATE_LANDING "landing" //We're currently landing.
#define SHUTTLE_STATE_LANDED "landed" //We have landed.
#define SHUTTLE_STATE_WAITING "waiting" //We have enough people to launch, now we wait just for more, just in case.

var/global/list/all_shuttle_controlers = list()

/obj/shuttle_controller
	name = "shuttle controller"
	desc = "Controls what happens when the shuttle moves."
	icon = 'icons/obj/shuttle.dmi'
	icon_state = "shuttle"
	invisibility = 101

	var/state = SHUTTLE_STATE_LANDED
	var/time = 0
	var/transit_time = 0

	var/display

	var/transit_source
	var/transit_target

	var/transit_start
	var/transit_bluespace
	var/transit_end

	var/default_transit_time = SHUTTLE_DEFAULT_TRANSIT_TIME
	var/default_waiting_time = SHUTTLE_DEFAULT_WAITING_TIME

	anchored = TRUE

/obj/shuttle_controller/New(var/desired_loc)
	all_shuttle_controlers += src
	return ..()

/obj/shuttle_controller/Initialize()
	set_doors(TRUE,TRUE)
	return ..()

/obj/shuttle_controller/proc/signal_landing(var/area/transit/landing_area)
	for(var/turf/T in landing_area.contents)
		new/obj/effect/temp/shuttle_landing(T)

/obj/shuttle_controller/proc/launch(var/desired_transit_time) //In deciseconds

	if(!default_transit_time)
		default_transit_time = default_transit_time

	desired_transit_time = max(30,desired_transit_time)

	set_doors(FALSE,TRUE)
	play_sound('sounds/effects/shuttle/hyperspace_begin.ogg',all_mobs_with_clients,vector(x,y,z),range_min=VIEW_RANGE,range_max=VIEW_RANGE*3)
	state = SHUTTLE_STATE_LAUNCHING
	time = 0
	transit_time = desired_transit_time
	var/area/A = get_area(src)
	if(A.id == transit_start)
		transit_target = transit_end
		transit_source = transit_start
	else
		transit_target = transit_start
		transit_source = transit_end

/obj/shuttle_controller/proc/set_doors(var/open = TRUE,var/lock = FALSE)

	var/area/A = get_area(src)
	for(var/obj/structure/interactive/door/airlock/shuttle/S in A.contents)

		var/exposed_to_space = FALSE
		for(var/direction in DIRECTIONS_CARDINAL)
			var/turf/T = get_step(S,direction)
			if(istype(T.loc,/area/space/))
				exposed_to_space = TRUE

		if(!exposed_to_space && open)
			S.open(!lock,TRUE)
		else
			S.close(lock,TRUE)

		if(!exposed_to_space)
			for(var/direction in DIRECTIONS_CARDINAL)
				var/turf/T = get_step(S,direction)
				var/obj/structure/interactive/door/airlock/AL = locate() in T.contents
				if(AL && !istype(AL,/obj/structure/interactive/door/airlock/shuttle/))
					if(open)
						AL.open(!lock,TRUE)
					else
						AL.close(lock,TRUE)

	return TRUE

/obj/shuttle_controller/proc/on_shuttle_think()

	if(state == SHUTTLE_STATE_WAITING)
		display = get_clock_time(floor((default_waiting_time - time)/10))
		if(time >= default_waiting_time)
			launch()

	if(state == SHUTTLE_STATE_LAUNCHING)
		display = "Launch"
		if(time >= 60) //Needs to be hardcoded as this is based on sound.
			transit(transit_source,transit_bluespace)
			play_sound('sounds/effects/shuttle/hyperspace_progress.ogg',all_mobs_with_clients,vector(x,y,z),range_min=VIEW_RANGE,range_max=VIEW_RANGE*3)

			state = SHUTTLE_STATE_TRANSIT
			time = 0

	if(state == SHUTTLE_STATE_TRANSIT)
		display = get_clock_time(floor((transit_time - time)/10))
		if(time >= transit_time)
			state = SHUTTLE_STATE_LANDING
			signal_landing(transit_areas[transit_target])
			time = 0

	if(state == SHUTTLE_STATE_LANDING)
		display = "Landing"
		if(time >= 20) //Needs to be hardcoded as this is based on sound.
			transit(transit_bluespace,transit_target)
			set_doors(TRUE,TRUE)
			play_sound('sounds/effects/shuttle/hyperspace_end.ogg',all_mobs_with_clients,vector(x,y,z),range_min=VIEW_RANGE,range_max=VIEW_RANGE*3)
			state = SHUTTLE_STATE_LANDED
			time = 0
			transit_source = null
			transit_target = null

	var/area/A = get_area(src)

	for(var/obj/structure/interactive/status_display/SD in A.contents)
		SD.set_text(display)

	return TRUE


/obj/shuttle_controller/proc/transit(var/starting_transit_id,var/ending_transit_id)

	var/area/transit/starting_transit = transit_areas[starting_transit_id]
	var/area/transit/ending_transit = transit_areas[ending_transit_id]

	var/starting_cord_x = starting_transit.x
	var/starting_cord_y = starting_transit.y

	var/ending_cord_x = ending_transit.x
	var/ending_cord_y = ending_transit.y

	var/transit_throw_x = 0
	var/transit_throw_y = 0

	var/reverse = ending_transit_id != transit_bluespace

	switch(src.dir)
		if(NORTH)
			transit_throw_y += reverse ? 1 : -1
		if(EAST)
			transit_throw_x += reverse ? 1 : -1
		if(SOUTH)
			transit_throw_y -= reverse ? 1 : -1
		if(WEST)
			transit_throw_x -= reverse ? 1 : -1

	var/list/atom/movable/objects_to_throw = list()

	for(var/turf/T in starting_transit)
		CHECK_TICK
		var/offset_x = T.x - starting_cord_x
		var/offset_y = T.y - starting_cord_y
		var/turf/replacing_turf = locate(ending_cord_x + offset_x, ending_cord_y + offset_y, 1)
		replacing_turf.change_turf(T.type)
		for(var/atom/movable/M in T.contents)
			CHECK_TICK
			if(!M.allow_shuttle_move)
				continue
			M.move_delay = SECONDS_TO_TICKS(3)
			M.force_move(replacing_turf)
			if(!M.anchored)
				objects_to_throw += M
		T.change_turf(/turf/simulated/floor/plating)

	for(var/atom/movable/M in objects_to_throw)
		if(M.anchored || M.collision_flags & FLAG_COLLISION_ETHEREAL)
			continue
		M.throw_self(M,null,null,null,transit_throw_x*16,transit_throw_y*16)

	return TRUE