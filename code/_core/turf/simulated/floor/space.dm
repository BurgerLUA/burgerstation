/turf/simulated/floor/space
	name = "space"
	icon = 'icons/turf/space/space.dmi'
	icon_state = "1"
	var/generate = TRUE

	light_power = 1
	light_range = 4
	light_color = "#CCD9E8"

/turf/simulated/floor/space/New()
	. = ..()
	set_light(light_range,light_power,light_color)
	update_icon()
	return TRUE

/turf/simulated/floor/space/update_icon()
	icon_state = "[rand(0,25)]"


/turf/simulated/floor/space/transit
	icon_state = "speedspace_ew_1"

/turf/simulated/floor/space/transit/update_icon()
	icon_state = "speedspace_ew_[rand(1,15)]"
	return