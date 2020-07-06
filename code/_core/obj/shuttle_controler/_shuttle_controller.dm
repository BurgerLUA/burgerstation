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
	var/default_transit_time_no_living = SHUTTLE_DEFAULT_TRANSIT_TIME_NO_LIVING
	var/default_waiting_time = SHUTTLE_DEFAULT_WAITING_TIME

	anchored = TRUE

	var/status_id

	initialize_type = INITIALIZE_LATE

	var/mob/last_caller = null //The last caller who interacted with this shuttle's launch, if any.

/obj/shuttle_controller/Destroy()
	all_shuttle_controlers -= src
	return ..()

/obj/shuttle_controller/New(var/desired_loc)
	all_shuttle_controlers += src
	return ..()

/obj/shuttle_controller/Initialize()

	var/area/A1 = transit_areas[transit_start]
	var/area/A2 = transit_areas[transit_bluespace]
	var/area/A3 = transit_areas[transit_end]

	if(!A1)
		log_error("ERROR: Transit shuttle [get_debug_name()] doesn't have a valid transit starting area ([transit_start])!")

	if(!A2)
		log_error("ERROR: Transit shuttle [get_debug_name()] doesn't have a valid transit bluespace area ([transit_bluespace])!")

	if(!A3)
		log_error("ERROR: Transit shuttle [get_debug_name()] doesn't have a valid transit ending area ([transit_end])!")

	if(!A1 || !A2 || !A3)
		qdel(src)
		return FALSE

	. =..()

	set_doors(TRUE,TRUE,TRUE) //Open and bolt all the doors!

	return .

/obj/shuttle_controller/proc/signal_landing(var/area/transit/landing_area)
	for(var/turf/T in landing_area.contents)
		new/obj/effect/temp/shuttle_landing(T)

/obj/shuttle_controller/proc/launch(var/mob/caller,var/desired_transit_time) //In deciseconds

	if(!set_doors(FALSE,TRUE,TRUE)) //Something blocking?
		return FALSE
	last_caller = caller
	state = SHUTTLE_STATE_LAUNCHING
	time = 0

	play('sound/effects/shuttle/hyperspace_begin.ogg',src,range_min=VIEW_RANGE,range_max=VIEW_RANGE*3)
	if(last_caller)
		create_alert(VIEW_RANGE*3,src,last_caller,ALERT_LEVEL_CAUTION)

	if(!desired_transit_time)
		desired_transit_time = default_transit_time_no_living
		for(var/mob/living/advanced/P in get_area(src))
			if(P.dead)
				continue
			desired_transit_time = default_transit_time
			break
	transit_time = max(10,desired_transit_time)
	var/area/A = get_area(src)
	if(A.id == transit_start)
		transit_target = transit_end
		transit_source = transit_start
	else
		transit_target = transit_start
		transit_source = transit_end
	return TRUE

/obj/shuttle_controller/proc/set_doors(var/open = TRUE,var/lock = FALSE,var/force = FALSE)

	. = TRUE //TRUE if nothing went wrong. False if something went wrong.

	var/area/A = get_area(src)

	for(var/obj/structure/interactive/door/airlock/shuttle/S in A.contents)

		var/obj/structure/interactive/scanner/living/S1 = locate() in S.loc.contents
		if(S1 && !S1.trigger(null,src,-1,-1)) //Unsafe to close.
			. = FALSE
			break

		var/exposed_to_space = S.get_best_touching_space(FALSE)

		for(var/direction in DIRECTIONS_CARDINAL)
			var/turf/T = get_step(S,direction)
			var/obj/structure/interactive/scanner/living/S2 = locate() in T.contents
			if(S2 && !S2.trigger(null,src,-1,-1))
				. = FALSE //Unsafe to close.
				break

			var/obj/structure/interactive/door/airlock/AL = locate() in T.contents
			if(!AL || istype(AL,/obj/structure/interactive/door/airlock/shuttle/))
				//No airlock? Whatever, keep going.
				continue

			if(open)
				AL.open(null,lock,force)
			else
				AL.close(null,lock,force)

		if(.)
			if(open && !exposed_to_space)
				S.open(null,lock,force)
			else
				S.close(null,lock,force)
	return .

/obj/shuttle_controller/proc/on_shuttle_think()

	if(state == SHUTTLE_STATE_WAITING)
		display = "Prep\n[get_clock_time(FLOOR((default_waiting_time - time), 1))]"
		if(time >= default_waiting_time)
			if(!launch())
				time -= 5

	if(state == SHUTTLE_STATE_LAUNCHING)
		display = "IGNT"
		if(time >= 6) //Needs to be hardcoded as this is based on sound.
			if(!transit(transit_source,transit_bluespace))
				return FALSE
			play('sound/effects/shuttle/hyperspace_progress.ogg',src,range_min=VIEW_RANGE,range_max=VIEW_RANGE*3)
			if(last_caller)
				create_alert(VIEW_RANGE*3,src,last_caller,ALERT_LEVEL_CAUTION)
			state = SHUTTLE_STATE_TRANSIT
			time = 0

	if(state == SHUTTLE_STATE_TRANSIT)
		display = "Flight\n[get_clock_time(FLOOR((transit_time - time), 1))]"
		if(time >= transit_time)
			state = SHUTTLE_STATE_LANDING
			signal_landing(transit_areas[transit_target])
			time = 0

	if(state == SHUTTLE_STATE_LANDING)
		display = "Land"
		if(time >= 2) //Needs to be hardcoded as this is based on sound.
			if(!transit(transit_bluespace,transit_target))
				return FALSE
			set_doors(TRUE,TRUE,TRUE) //Open all the doors!
			play('sound/effects/shuttle/hyperspace_end.ogg',src,range_min=VIEW_RANGE,range_max=VIEW_RANGE*3)
			if(last_caller)
				create_alert(VIEW_RANGE,src,last_caller,ALERT_LEVEL_CAUTION)
			state = SHUTTLE_STATE_LANDED
			time = 0
			transit_source = null
			transit_target = null

	var/area/A = get_area(src)

	for(var/obj/structure/interactive/status_display/shuttle/SD in A.contents)
		SD.set_text(display)

	if(status_id)
		set_status_display(status_id,display)

	return TRUE


/obj/shuttle_controller/proc/transit(var/starting_transit_id,var/ending_transit_id)

	var/area/transit/starting_transit = transit_areas[starting_transit_id]
	var/area/transit/ending_transit = transit_areas[ending_transit_id]

	var/starting_cord_x = starting_transit.x
	var/starting_cord_y = starting_transit.y

	var/ending_cord_x = ending_transit.x
	var/ending_cord_y = ending_transit.y
	var/ending_cord_z = ending_transit.z

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
		if(T.plane != PLANE_SHUTTLE)
			continue
		var/offset_x = T.x - starting_cord_x
		var/offset_y = T.y - starting_cord_y
		var/turf/replacing_turf = locate(ending_cord_x + offset_x, ending_cord_y + offset_y, ending_cord_z)
		replacing_turf.change_turf(T.type,TRUE,TRUE)
		for(var/atom/movable/M in T.contents)
			CHECK_TICK
			if(!M.allow_shuttle_move)
				continue
			M.move_delay = SECONDS_TO_TICKS(3)
			M.force_move(replacing_turf)
			objects_to_throw += M
		T.change_turf(starting_transit.transit_turf,TRUE,TRUE)

	for(var/atom/movable/M in objects_to_throw)
		if(M.anchored || M.collision_flags & FLAG_COLLISION_ETHEREAL)
			continue
		if(istype(M,/obj/structure/))
			continue
		if(is_living(M) && locate(/obj/structure/interactive/chair) in M.loc.contents)
			continue
		M.throw_self(M,null,null,null,transit_throw_x*8,transit_throw_y*8)

	return TRUE