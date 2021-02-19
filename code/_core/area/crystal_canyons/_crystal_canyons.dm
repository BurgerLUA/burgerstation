
/area/crystalcanyon
	trackable = TRUE
	area_identifier = "Mission"

/area/crystalcanyon/outside
	name = "\improper Crystal Plains"
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
	name = "\improper Central Crystal Caves"
	icon_state = "cave"
	tracks = TRACKS_CAVE
	random_sounds = list(
		'sound/ambient/cave_1.ogg',
		'sound/ambient/cave_2.ogg',
	)
	cheese_type = /reagent/nutrition/cheese/gruyere

	sound_environment = ENVIRONMENT_QUARRY

/area/crystalcanyon/interior/cave/north
	name = "\improper Northern Crystal Caves"
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
	name = "\improper Southern Crystal Caves"
	icon_state = "red"

/area/crystalcanyon/interior/cave/east
	name = "\improper Eastern Crystal Caves"
	icon_state = "green"

/area/crystalcanyon/interior/cave/west
	name = "\improper Western Crystal Caves"
	icon_state = "yellow"

/area/crystalcanyon/caves/xenohive
	name = "\improper Xenomorph Hive"
	icon_state = "hive"

	tracks = null

/area/crystalcanyon/deltaclinic
	name = "\improper Crystal Caves  Delta Clinic"
	icon_state = "med"

/area/crystalcanyon/bravobngine
	name = "\improper Crystal Caves  Engineering Outpost"
	icon_state = "eng"

/area/crystalcanyon/charliebase
	name = "\improper Crystal Caves Mining Base"
	icon_state = "mining"

/area/crystalcanyon/interior/revbar
	name = "\improper Revolutionary Bar"
	icon_state = "red"

/area/crystalcanyon/interior/playerrev
	name = "\improper Revolutionary Base"
	icon_state = "red"

/area/crystalcanyon/downedshuttle
	name = "\improper Crystal Caves Downed Gulf"
	icon_state = "red"

/area/crystalcanyon/clownplace
	name = "\improper Crystal Caves Honk Lab"
	icon_state = "green"

area/crystalcanyon/interior/syndiship
	name = "\improper Syndicate Ship"
	icon_state = "red"