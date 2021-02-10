/area/lz_001/caves
	name = "\improper Unexplored Caves"
	icon_state = "cave"
	tracks = TRACKS_CAVE
	random_sounds = list(
		'sound/ambient/cave_1.ogg',
		'sound/ambient/cave_2.ogg',
	)
	cheese_type = /reagent/nutrition/cheese/gruyere

	interior = TRUE

	sound_environment = ENVIRONMENT_QUARRY

/area/lz_001/caves/lava
	name = "\improper Magma Caves"
	icon_state = "lava_cave"

	//sunlight_power = 1
	sunlight_freq = 8
	sunlight_color ="#7F3B11"

	random_sounds = list(
		'sound/ambient/lavacaves_1.ogg',
		'sound/ambient/lavacaves_2.ogg',
	)

	tracks = TRACKS_LAVA

	cheese_type = /reagent/nutrition/cheese/guava


/area/lz_001/caves/lava/brighter
	name = "\improper Magma Caves Hellchamber"
	icon_state = "volcanic"
	weather = WEATHER_VOLCANIC
	ambient_temperature = T0C + 80

	desired_light_range = 8
	desired_light_power = 1

	sunlight_color ="#A8663F"


/area/lz_001/caves/crab
	name = "King Crab's Burrow"
	icon_state = "king_crab"

	tracks = null

/area/lz_001/caves/ocean_pass
	name = "Ocean's Pass"
	icon_state = "ocean_pass"

	tracks = null

/area/lz_001/caves/diamond_cave
	name = "Diamond's Cave"
	icon_state = "diamond_cave"

	tracks = null

/area/lz_001/caves/glow_cave
	name = "Glowshroom Cave"
	icon_state = "glow_cave"

	tracks = null

/area/lz_001/caves/desert_cave
	name = "Sandraider's Cave"
	icon_state = "desert_cave"

	tracks = null

/area/lz_001/caves/lagoon
	name = "Pirate's Lagoon"
	icon_state = "lagoon"

	sunlight_freq = 8
	sunlight_color ="#8CB08F"

	tracks = null

/area/lz_001/caves/lagoon/ship
	name = "Captain Condom's Ship"
	icon_state = "ship"

	sunlight_freq = 8
	sunlight_color ="#8CB08F"

	tracks = null

/area/lz_001/caves/knight/
	name = "Knight's Landing"
	icon_state = "day"

	sunlight_freq = 8
	sunlight_color ="#AEB05D"

	tracks = null

/area/lz_001/caves/knight/cave
	name = "Knight's Landing Cave"
	icon_state = "knight"

	tracks = null

/area/lz_001/caves/hive
	name = "\improper Alien Hive"
	icon_state = "hive"

	tracks = null