/area/mission
	name = "MISSION AREA ERROR"
	area_identifier = "Mission"

	dynamic_lighting = TRUE
	trackable = FALSE


/area/mission/desert
	name = "Desert"
	icon_state = "desert"

	weather = WEATHER_SANDSTORM
	ambient_temperature = T0C + 80
	cheese_type = /reagent/nutrition/cheese/kadchgall

	sunlight_freq = 8
	sunlight_color = "#724C2B"

	sound_environment = ENVIRONMENT_PLAIN

/area/mission/desert/interior
	name = "\improper Desert Caves"
	icon_state = "desert_cave"

	weather = null
	ambient_temperature = T0C + 40
	cheese_type = /reagent/nutrition/cheese/kadchgall

	sunlight_freq = null
	sunlight_color = null

	interior = TRUE
	sound_environment = ENVIRONMENT_QUARRY

	tracks = TRACKS_CAVE
	random_sounds = list(
		'sound/ambient/cave_1.ogg',
		'sound/ambient/cave_2.ogg',
	)



/area/mission/forest
	name = "Forest"
	icon_state = "forest"

	weather = null
	ambient_temperature = T0C + 15
	cheese_type = /reagent/nutrition/cheese/cheddar

	sunlight_freq = 8
	sunlight_color = "#CCB06A"

	interior = FALSE
	sound_environment = ENVIRONMENT_PLAIN

	//Note: No such thing as forest interior. See caves for this.


/area/mission/caves
	name = "\improper Unexplored Caves"
	icon_state = "cave"

	weather = null
	ambient_temperature = T0C + 10
	cheese_type = /reagent/nutrition/cheese/gruyere

	sunlight_freq = null
	sunlight_color = null

	interior = TRUE
	sound_environment = ENVIRONMENT_QUARRY
	tracks = TRACKS_CAVE
	random_sounds = list(
		'sound/ambient/cave_1.ogg',
		'sound/ambient/cave_2.ogg',
	)


/area/mission/jungle
	name = "\improper Vinetangle Jungle"
	icon_state = "jungle"

	weather = WEATHER_RAIN
	ambient_temperature = T0C + 40
	cheese_type = /reagent/nutrition/cheese/brabander

	sunlight_freq = 8
	sunlight_color = "#29332C"

	interior = FALSE
	sound_environment = ENVIRONMENT_PLAIN
	tracks = TRACKS_JUNGLE
	ambient_sound = 'sound/ambient/crickets.ogg'
	random_sounds = list(
		'sound/ambient/ambiruin_1.ogg',
		'sound/ambient/ambiruin_2.ogg',
		'sound/ambient/ambiruin_3.ogg',
		'sound/ambient/ambiruin_4.ogg',
		'sound/ambient/ambiruin_5.ogg',
		'sound/ambient/ambiruin_6.ogg',
		'sound/ambient/ambiruin_7.ogg',
	)

/area/mission/jungle/interior
	name = "\improper Deep Vinetangle Jungle"
	icon_state = "jungle_interior"

	weather = null
	ambient_temperature = T0C + 30
	cheese_type = /reagent/nutrition/cheese/brabander

	sunlight_freq = null
	sunlight_color = null

	interior = FALSE
	sound_environment = ENVIRONMENT_PLAIN
	tracks = TRACKS_JUNGLE
	ambient_sound = 'sound/ambient/crickets.ogg'
	random_sounds = list(
		'sound/ambient/ambiruin_1.ogg',
		'sound/ambient/ambiruin_2.ogg',
		'sound/ambient/ambiruin_3.ogg',
		'sound/ambient/ambiruin_4.ogg',
		'sound/ambient/ambiruin_5.ogg',
		'sound/ambient/ambiruin_6.ogg',
		'sound/ambient/ambiruin_7.ogg',
	)



/area/mission/lava
	name = "\improper The Magmachamber"
	icon_state = "lava_cave"

	weather = null
	ambient_temperature = T0C + 90
	cheese_type = /reagent/nutrition/cheese/guava

	sunlight_freq = 8
	sunlight_color ="#7F3B11"

	interior = TRUE
	sound_environment = ENVIRONMENT_QUARRY
	tracks = TRACKS_LAVA
	random_sounds = list(
		'sound/ambient/lavacaves_1.ogg',
		'sound/ambient/lavacaves_2.ogg',
	)

/area/mission/beach
	name = "Beach"
	icon_state = "beach"

	weather = null
	ambient_temperature = T0C + 30
	cheese_type = /reagent/nutrition/cheese/cheddar

	sunlight_freq = 8
	sunlight_color = "#BCA04B"

	sound_environment = ENVIRONMENT_PLAIN

/area/mission/ocean
	name = "Ocean"
	icon_state = "ocean"

	weather = null
	ambient_temperature = T0C + 40
	cheese_type = /reagent/nutrition/cheese/cheddar

	sunlight_freq = 8
	sunlight_color = "#6B99C4"

	sound_environment = ENVIRONMENT_PLAIN


/area/mission/river
	name = "River"
	icon_state = "river"

	weather = null
	ambient_temperature = T0C + 20
	cheese_type = /reagent/nutrition/cheese/cheddar

	sunlight_freq = 8
	sunlight_color = "#93B08C"

	sound_environment = ENVIRONMENT_PLAIN


/area/mission/out_of_bounds
	name = "Out of Bounds"
	icon_state = "error"

	interior = TRUE