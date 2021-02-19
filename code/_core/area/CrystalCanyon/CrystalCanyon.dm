/area/crystalcanyon/Outside
	name = "CrystalPlains"
	icon_state = "snow"
	weather = WEATHER_SNOW
	ambient_temperature = T0C - 20
	hazard = "cold"
	sunlight_freq = 4
	sunlight_color = "#1A3E4C"

	cheese_type = /reagent/nutrition/cheese/raclette

	tracks = TRACKS_MOUNTAIN

	sound_environment = ENVIRONMENT_PLAIN
/area/crystalcanyon/interior/cave
	name = "Central Caves"
	icon_state = "cave"
	tracks = TRACKS_CAVE
	random_sounds = list(
		'sound/ambient/cave_1.ogg',
		'sound/ambient/cave_2.ogg',
	)
	cheese_type = /reagent/nutrition/cheese/gruyere

	sound_environment = ENVIRONMENT_QUARRY

/area/crystalcanyon/interior/cave/north
	name = "Northern Caves"
	icon_state = "blue"

	sunlight_freq = 8
	sunlight_color ="#7F3B11"

	random_sounds = list(
		'sound/ambient/lavacaves_1.ogg',
		'sound/ambient/lavacaves_2.ogg',
	)

	tracks = TRACKS_LAVA

	cheese_type = /reagent/nutrition/cheese/guava

/area/crystalcanyon/interior/cave/south
	name = "Southern Caves"
	icon_state = "red"

/area/crystalcanyon/interior/cave/east
	name = "Eastern Caves"
	icon_state = "green"

/area/crystalcanyon/interior/cave/west
	name = "Western Caves"
	icon_state = "yellow"

/area/crystalcanyon/caves/xenohive
	name = "Xenomorph Hive"
	icon_state = "hive"

	tracks = null

/area/crystalcanyon/deltaclinic
	name = "Delta Clinic"
	icon_state = "med"

/area/crystalcanyon/bravobngine
	name = "Engineering outpost"
	icon_state = "eng"

/area/crystalcanyon/charliebase
	name = "Mining base"
	icon_state = "mining"

/area/crystalcanyon/interior/revbar
	name = "Revolutionary Bar"
	icon_state = "red"

/area/crystalcanyon/interior/playerrev
	name = "Revolutionary Base"
	icon_state = "red"
