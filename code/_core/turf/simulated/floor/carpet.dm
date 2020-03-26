/turf/simulated/floor/carpet
	name = "carpet"
	icon = 'icons/turf/floor/carpet.dmi'
	icon_state = "floor"
	corner_icons = TRUE
	corner_category = "carpet"

	footstep_id = "carpet"


/turf/simulated/floor/carpet_office
	name = "office carpet"
	icon = 'icons/turf/floor/carpet_office.dmi'
	icon_state = "1"
	footstep_id = "carpet"

/turf/simulated/floor/carpet_office/New(var/desired_loc)
	. = ..()
	icon_state = "[rand(1,4)]"
	return .
