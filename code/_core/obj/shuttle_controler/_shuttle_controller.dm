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
	invisibility = 101

	var/state = SHUTTLE_STATE_LANDED
	var/time = 0
	var/transit_time = 0

	var/transit_source
	var/transit_target

	var/transit_start
	var/transit_bluespace
	var/transit_end

	var/default_transit_time = 600

/obj/shuttle_controller/New(var/desired_loc)
	all_shuttle_controlers += src
	return ..()

/obj/shuttle_controller/Initialize()
	spawn(20)
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
			if(istype(T.loc,/area/horde/space/))
				exposed_to_space = TRUE

		if(!exposed_to_space && open)
			S.open(!lock,TRUE)
		else
			world.log << "Closing [S.name]."
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

	time++

	if(state == SHUTTLE_STATE_WAITING)
		if(time < 100)
			return TRUE
		launch()

	if(state == SHUTTLE_STATE_LAUNCHING)
		if(time < 60)
			return TRUE
		transit(transit_source,transit_bluespace)
		play_sound('sounds/effects/shuttle/hyperspace_progress.ogg',all_mobs_with_clients,vector(x,y,z),range_min=VIEW_RANGE,range_max=VIEW_RANGE*3)

		state = SHUTTLE_STATE_TRANSIT
		time = 0

	if(state == SHUTTLE_STATE_TRANSIT)
		if(time < transit_time)
			return TRUE
		state = SHUTTLE_STATE_LANDING
		signal_landing(transit_areas[transit_target])
		time = 0

	if(state == SHUTTLE_STATE_LANDING)
		if(time < 20)
			return TRUE
		transit(transit_bluespace,transit_target)
		set_doors(TRUE,TRUE)
		play_sound('sounds/effects/shuttle/hyperspace_end.ogg',all_mobs_with_clients,vector(x,y,z),range_min=VIEW_RANGE,range_max=VIEW_RANGE*3)
		state = SHUTTLE_STATE_LANDED
		time = 0
		transit_source = null
		transit_target = null

	return TRUE


/obj/shuttle_controller/proc/transit(var/starting_transit_id,var/ending_transit_id)

	var/area/transit/starting_transit = transit_areas[starting_transit_id]
	var/area/transit/ending_transit = transit_areas[ending_transit_id]

	var/starting_cord_x = starting_transit.x
	var/starting_cord_y = starting_transit.y

	var/ending_cord_x = ending_transit.x
	var/ending_cord_y = ending_transit.y

	for(var/turf/T in starting_transit)
		var/offset_x = T.x - starting_cord_x
		var/offset_y = T.y - starting_cord_y
		var/turf/replacing_turf = locate(ending_cord_x + offset_x, ending_cord_y + offset_y, 1)
		replacing_turf.change_turf(T.type)
		for(var/atom/movable/M in T.contents)
			if(!M.allow_shuttle_move)
				continue
			M.force_move(replacing_turf)
		T.change_turf(/turf/simulated/floor/plating)

	return TRUE