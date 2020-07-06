/area/lz_001/caves
	name = "Unexplored Caves"
	icon_state = "cave"
	random_sounds = list(
		'sound/ambient/cave_1.ogg',
		'sound/ambient/cave_2.ogg',
	)
	cheese_type = /reagent/nutrition/cheese/gruyere
	roof = TRUE

/area/lz_001/caves/lava
	name = "lava cave"
	icon_state = "lava_cave"

	//sunlight_power = 1
	sunlight_freq = 8
	sunlight_color ="#7F3B11"

	random_sounds = list(
		'sound/ambient/lavacaves_1.ogg',
		'sound/ambient/lavacaves_2.ogg',
	)

	cheese_type = /reagent/nutrition/cheese/guava

	roof = FALSE //I mean yes, but actually no.


/area/lz_001/caves/lava/brighter
	sunlight_color ="#A8663F"

/area/lz_001/caves/crab
	name = "\improper King Crab's Burrow"
	icon_state = "king_crab"

/area/lz_001/caves/ocean_pass
	name = "\improper Ocean's Pass"
	icon_state = "ocean_pass"

/area/lz_001/caves/diamond_cave
	name = "\improper Diamond's Cave"
	icon_state = "diamond_cave"

/area/lz_001/caves/glow_cave
	name = "\improper Glowshroom Cave"
	icon_state = "glow_cave"

/area/lz_001/caves/desert_cave
	name = "\improper Sandraider's Cave"
	icon_state = "desert_cave"

/area/lz_001/caves/lagoon
	name = "\improper Pirate's Lagoon"
	icon_state = "lagoon"
	roof = FALSE

	sunlight_freq = 8
	sunlight_color ="#8CB08F"

/area/lz_001/caves/knight/
	name = "\improper Knight's Landing"
	icon_state = "day"
	roof = FALSE

	sunlight_freq = 8
	sunlight_color ="#AEB05D"

/area/lz_001/caves/knight/cave
	name = "\improper Knight's Landing Cave"
	icon_state = "knight"
	roof = TRUE

/area/lz_001/caves/hive
	name = "\improper Alien Hive"
	icon_state = "hive"
	roof = TRUE