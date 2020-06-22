/turf/simulated/floor/sand
	name = "sand"
	icon = 'icons/turf/floor/natural.dmi'
	icon_state = "sand1"

	footstep = /footstep/sand

/turf/simulated/floor/sand/New(var/desired_loc)
	icon_state = "sand[rand(1,4)]"
	. = ..()


/turf/simulated/floor/red_sand
	name = "sand"
	icon = 'icons/turf/floor/natural.dmi'
	icon_state = "ironsand1"

/turf/simulated/floor/red_sand/New(var/desired_loc)
	icon_state = "ironsand[rand(1,15)]"
	. = ..()