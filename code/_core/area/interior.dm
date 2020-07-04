/area/interior/

/area/interior/roof
	name = "roof"
	icon_state = "roof"








/area/interior/cave/lava/setup_sunlight(var/turf/T)

	if(istype(T,/turf/simulated/floor/lava/))

		if( (T.x % FLOOR(sunlight_freq*0.5, 1)) || (T.y % FLOOR(sunlight_freq*0.5, 1)) )
			return FALSE

		T.set_light(sunlight_freq+1,desired_light_power,"#CE631C")
		return TRUE

	return ..()



/area/interior/syndicate_base
	name = "syndicate base"
	icon_state = "syndie"

/area/interior/station
	name = "Central Command"
	icon_state = "cmd"
	flags_area = FLAGS_AREA_NO_DAMAGE | FLAGS_AREA_NO_CONSTRUCTION | FLAGS_AREA_NO_ROUND_INFORMATION | FLAGS_AREA_TUTORIAL

	ambient_sound = 'sound/ambient/station_loop.ogg'
	random_sounds = list(
		'sound/ambient/station_1.ogg',
		'sound/ambient/station_2.ogg',
		'sound/ambient/station_3.ogg',
		'sound/ambient/station_4.ogg',
		'sound/ambient/station_5.ogg',
		'sound/ambient/station_6.ogg',
		'sound/ambient/station_7.ogg',
		'sound/ambient/station_8.ogg',
		'sound/ambient/station_9.ogg',
		'sound/ambient/station_10.ogg',
		'sound/ambient/station_11.ogg',
		'sound/ambient/station_12.ogg',
		'sound/ambient/station_13.ogg'
	)

/area/interior/station/singleplayer
	name = "Home"
	icon_state = "solo"
	flags_area = FLAGS_AREA_NO_DAMAGE | FLAGS_AREA_NO_CONSTRUCTION | FLAGS_AREA_SINGLEPLAYER