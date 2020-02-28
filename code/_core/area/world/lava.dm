/area/world/lava //1,3; 1,4; 2,3
	name = "lavaland"
	id = "lavaland"

	tracks = TRACKS_LAVA

/area/world/lava/exterior
	name = "lavaland exterior"
	icon_state = "red"
	area_light_power = DEFAULT_BRIGHTNESS_MUL_EXTERIOR

	sunlight_freq = 8

	desired_light_range = 8
	desired_light_power = 1
	desired_light_color = "#684934"

/area/world/lava/exterior/setup_sunlight(var/turf/T)

	if(istype(T,/turf/simulated/floor/lava/))

		if( (T.x % FLOOR(sunlight_freq*0.5, 1)) || (T.y % FLOOR(sunlight_freq*0.5, 1)) )
			return FALSE

		T.set_light(sunlight_freq+1,desired_light_power,"#CE631C")
		return TRUE

	return ..()

/area/world/lava/interior

/area/world/lava/exterior/chapel
	name = "chapel"
	icon_state = "safe"
	safe = TRUE

/area/world/lava/interior/chapel
	name = "chapel shop"
	icon_state = "shop"
	id = "chapel_shop"
	safe = TRUE

/area/world/lava/lab
	name = "the lab"
	icon_state = "green"
	area_light_power = DEFAULT_BRIGHTNESS_MUL_INTERIOR

/area/world/lava/safezone
	name = "lavaland safezone"
	icon_state = "safe"
	area_light_power = DEFAULT_BRIGHTNESS_MUL_INTERIOR