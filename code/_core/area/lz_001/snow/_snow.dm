/area/lz_001/snow
	name = "\improper White Forest"
	icon_state = "snow"
	weather = WEATHER_SNOW
	ambient_temperature = T0C - 20
	hazard = "cold"
	sunlight_freq = 8
	sunlight_color = "#898989"

	cheese_type = /reagent/nutrition/cheese/raclette

	tracks = TRACKS_MOUNTAIN

	sound_environment = ENVIRONMENT_PLAIN


/area/lz_001/snow/interior
	sunlight_freq = 0
	interior = TRUE

	sound_environment = ENVIRONMENT_STONEROOM

/area/lz_001/snow/interior/lodge
	name = "\improper White Forest Lodge"
	icon_state = "bar"


/area/lz_001/snow/interior/shack
	name = "\improper Abandoned White Forest Mining Shack"
	icon_state = "mining"