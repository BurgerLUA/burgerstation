var/global/list/area/all_areas_with_dynamic_sunlight = list()

var/global/time_of_day = DAY

/proc/change_time_of_day(var/desired_time_of_day)

	if(time_of_day == desired_time_of_day)
		return FALSE

	for(var/area/A in all_areas_with_dynamic_sunlight)
		var/desired_color = time_of_day ? A.desired_light_color : "#111111"
		for(var/turf/T in A.sunlight_turfs)
			T.set_light(A.sunlight_freq+1,A.desired_light_power,desired_color)

	return TRUE