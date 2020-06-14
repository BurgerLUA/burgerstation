/turf/simulated/floor/xenomorph/
	name = "resin floor"

	icon = 'icons/turf/floor/icons.dmi'
	icon_state = "xenomorph"

	real_icon = 'icons/turf/floor/resin_01.dmi'
	real_icon_state = "floor"

	corner_icons = TRUE
	corner_category = "xenomorph"

	footstep_id = "concrete"

	var/glow = FALSE

	layer = LAYER_FLOOR_DECAL

/turf/simulated/floor/xenomorph/New(var/desired_loc)

	if(prob(10))
		real_icon = 'icons/turf/floor/resin_04.dmi'
		glow = TRUE
	else
		real_icon = pick('icons/turf/floor/resin_01.dmi','icons/turf/floor/resin_02.dmi','icons/turf/floor/resin_03.dmi')

	return ..()

/turf/simulated/floor/xenomorph/Initialize()
	if(glow)
		set_light(VIEW_RANGE*0.5,0.25,"#A49EFF")
	return ..()

