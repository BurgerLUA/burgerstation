/area/mission
	name = "MISSION AREA ERROR"
	area_identifier = "Mission"

	dynamic_lighting = TRUE
	trackable = FALSE

	allow_area_expansion = TRUE

	horde_data = "mission"

/area/mission/below
	name = "\improper Underground"
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

	horde_data = /horde_data/cave

	allow_climbing = TRUE

/area/mission/desert
	name = "\improper Cliffside Sea Desert"
	icon_state = "desert"

	weather = WEATHER_SANDSTORM
	ambient_temperature = T0C + 80
	cheese_type = /reagent/nutrition/cheese/kadchgall

	sunlight_freq = 16
	sunlight_color = "#724C2B"

	sound_environment = ENVIRONMENT_PLAIN

	horde_data = /horde_data/desert

	dynamic_rock_gen_turf = /turf/simulated/wall/rock/desert

/area/mission/snow
	name = "\improper Snow Line"
	icon_state = "snow"
	weather = WEATHER_SNOW
	ambient_temperature = T0C - 20
	hazard = "cold"
	sunlight_freq = 16
	sunlight_color = "#898989"

	cheese_type = /reagent/nutrition/cheese/raclette

	tracks = TRACKS_MOUNTAIN

	sound_environment = ENVIRONMENT_PLAIN

	horde_data = /horde_data/snow

	interior = FALSE

	dynamic_rock_gen_turf = /turf/simulated/wall/rock

/area/mission/desert/interior
	name = "\improper Cliffside Sea Desert Caves"
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
	name = "Rael Forest"
	icon_state = "forest"

	weather = null
	ambient_temperature = T0C + 15
	cheese_type = /reagent/nutrition/cheese/cheddar

	sunlight_freq = 16
	sunlight_color = "#CCB06A"

	interior = FALSE
	sound_environment = ENVIRONMENT_PLAIN

	//Note: No such thing as forest interior. See caves for this.

	horde_data = /horde_data/forest

	dynamic_rock_gen_turf = /turf/simulated/wall/rock/brown

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

	horde_data = /horde_data/cave


/area/mission/jungle
	name = "\improper Vinetangle Jungle"
	icon_state = "jungle"

	weather = WEATHER_RAIN
	ambient_temperature = T0C + 40
	cheese_type = /reagent/nutrition/cheese/brabander

	sunlight_freq = 16
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

	horde_data = /horde_data/jungle

	dynamic_rock_gen_turf = /turf/simulated/wall/rock/moss

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

	sunlight_freq = 16
	sunlight_color ="#7F3B11"

	interior = TRUE
	sound_environment = ENVIRONMENT_QUARRY
	tracks = TRACKS_LAVA
	random_sounds = list(
		'sound/ambient/lavacaves_1.ogg',
		'sound/ambient/lavacaves_2.ogg',
	)

	horde_data = /horde_data/lava

	dynamic_rock_gen_turf = /turf/simulated/wall/rock/basalt

/area/mission/beach
	name = "Beach"
	icon_state = "beach"

	weather = null
	ambient_temperature = T0C + 30
	cheese_type = /reagent/nutrition/cheese/cheddar

	sunlight_freq = 16
	sunlight_color = "#BCA04B"

	sound_environment = ENVIRONMENT_PLAIN

	horde_data = /horde_data/beach

/area/mission/ocean
	name = "\improper Spannic Ocean"
	icon_state = "ocean"

	weather = null
	ambient_temperature = T0C + 40
	cheese_type = /reagent/nutrition/cheese/cheddar

	sunlight_freq = 16
	sunlight_color = "#6B99C4"

	sound_environment = ENVIRONMENT_PLAIN

	horde_data = /horde_data/beach

/area/mission/out_of_bounds
	name = "Out of Bounds"
	icon_state = "error"

	interior = TRUE

	dynamic_rock_gen_turf = /turf/simulated/wall/rock/indestructable