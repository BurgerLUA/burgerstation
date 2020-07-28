/turf/simulated/floor/xeno/
	name = "resin floor"

	icon = 'icons/turf/floor/icons.dmi'
	icon_state = "xeno"

	real_icon = 'icons/turf/floor/resin_1.dmi'
	real_icon_state = "floor"

	corner_icons = TRUE
	corner_category = "xeno"

	//footstep = /footstep/xeno

	var/glow = FALSE

	layer = LAYER_FLOOR_DECAL

/turf/simulated/floor/xeno/New(var/desired_loc)

	if(prob(5))
		real_icon = 'icons/turf/floor/resin_4.dmi'
		glow = TRUE
	else
		real_icon = pick('icons/turf/floor/resin_1.dmi','icons/turf/floor/resin_2.dmi','icons/turf/floor/resin_3.dmi')

	return ..()

/turf/simulated/floor/xeno/Initialize()
	if(glow)
		set_light(VIEW_RANGE*0.5,0.25,"#A49EFF")
	return ..()

