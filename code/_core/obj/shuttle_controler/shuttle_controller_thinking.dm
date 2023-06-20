/obj/shuttle_controller/proc/on_shuttle_think()

	if(state == SHUTTLE_STATE_WAITING)
		display = "Prep\n[get_clock_time(FLOOR((default_waiting_time - time), 1))]"
		if(time >= default_waiting_time)
			if(!launch())
				time -= 5

	if(state == SHUTTLE_STATE_LAUNCHING)
		display = "IGNT"
		if(time >= 6) //Needs to be a hardcoded time as this is based on sound.
			if(!transit(transit_marker_bluespace,accelerating=TRUE))
				state = SHUTTLE_STATE_WAITING
				time = 0
				return FALSE
			if(progress_sound)
				play_sound(progress_sound,src.loc,range_min=VIEW_RANGE,range_max=VIEW_RANGE*3)
				if(last_caller)
					create_alert(VIEW_RANGE*3,src.loc,last_caller,ALERT_LEVEL_CAUTION)
			state = SHUTTLE_STATE_TRANSIT
			time = 0

	if(state == SHUTTLE_STATE_TRANSIT)
		display = "Flight\n[get_clock_time(FLOOR((transit_time - time), 1))]"
		if(time >= transit_time)
			if(!transit_marker_destination)
				transit_marker_destination = transit_marker_base //Just in case something goes wrong.
				log_error("Shuttle Error: Something terribly went wrong and [src.get_debug_name()] had to return to base.")
			state = SHUTTLE_STATE_LANDING
			signal_landing(transit_marker_destination)
			time = 0

	if(state == SHUTTLE_STATE_LANDING)
		display = "Land"
		if(time >= 2) //Needs to be hardcoded as this is based on sound.
			if(!transit(transit_marker_destination,accelerating=FALSE))
				state = SHUTTLE_STATE_TRANSIT
				time = 0
				return FALSE
			set_doors(TRUE,TRUE,TRUE) //Open all the doors!
			if(end_sound)
				play_sound(end_sound,src.loc,range_min=VIEW_RANGE,range_max=VIEW_RANGE*3)
				if(last_caller)
					create_alert(VIEW_RANGE*3,src.loc,last_caller,ALERT_LEVEL_CAUTION)
			state = SHUTTLE_STATE_LANDED
			time = 0

	if(status_id) set_status_display(status_id,display)

	if(display)
		var/area/A = get_area(src)
		for(var/obj/structure/interactive/status_display/local_display/LD in A.contents)
			LD.set_text(display)
			CHECK_TICK(75,FPS_SERVER)

	return TRUE