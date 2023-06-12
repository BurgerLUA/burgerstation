/obj/shuttle_controller/proc/start_flight(var/mob/caller)

	if(!is_safe_to_land(caller,src.transit_marker_destination))
		return FALSE

	src.time = 0
	src.state = SHUTTLE_STATE_WAITING
	src.transit_marker_destination.set_reserved(TRUE) //Reserve the destination.

	return TRUE

/obj/shuttle_controller/proc/launch(var/mob/caller,var/desired_transit_time) //In deciseconds. This proc will always be called to bluespace.

	if(!set_doors(FALSE,TRUE,TRUE)) //This will return false if something is blocking the doors.
		time = time - 5 //Go back 5 seconds.
		return FALSE

	last_caller = caller
	state = SHUTTLE_STATE_LAUNCHING
	time = 0

	if(!desired_transit_time)
		desired_transit_time = default_transit_time

	transit_time = max(1,desired_transit_time)

	if(start_sound) //Play shuttle sound.
		play_sound(start_sound,src.loc,range_min=VIEW_RANGE,range_max=VIEW_RANGE*3)
		if(last_caller)
			create_alert(VIEW_RANGE*3,src.loc,last_caller,ALERT_LEVEL_CAUTION)

	return TRUE
