var/global/list/area/all_areas_with_dynamic_lighting_overlay_color = list()

var/global/time_of_day = DAY

/proc/change_time_of_day(var/desired_time_of_day)

	if(time_of_day == desired_time_of_day)
		return FALSE

	time_of_day = desired_time_of_day

	for(var/area/A in all_areas_with_dynamic_lighting_overlay_color)

		var/desired_color = (time_of_day == DAY) ?  A.lighting_overlay_color_day : A.lighting_overlay_color_night

		for(var/turf/T in A.contents)
			CHECK_TICK
			if(!T.lighting_overlay)
				continue
			T.lighting_overlay.color = desired_color
			T.lighting_overlay.update_overlay()

	return TRUE

client/verb/time_of_day_test()
	change_time_of_day(time_of_day == DAY ? NIGHT : DAY)