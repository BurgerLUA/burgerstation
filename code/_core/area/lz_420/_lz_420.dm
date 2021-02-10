/area/lz_420
	name = "LZ 420"
	area_identifier = "Mission"

/area/lz_420/exterior/
	name = "LZ-420 Exterior"
	icon_state = "jungle"
	weather = WEATHER_RAIN
	ambient_temperature = T0C + 40

	sunlight_freq = 8
	sunlight_color = "#29332C"

	cheese_type = /reagent/nutrition/cheese/brabander

	//ambient_sound = 'sound/ambient/crickets.ogg'

	random_sounds = list(
		'sound/ambient/ambiruin_1.ogg',
		'sound/ambient/ambiruin_2.ogg',
		'sound/ambient/ambiruin_3.ogg',
		'sound/ambient/ambiruin_4.ogg',
		'sound/ambient/ambiruin_5.ogg',
		'sound/ambient/ambiruin_6.ogg',
		'sound/ambient/ambiruin_7.ogg',
	)

	tracks = TRACKS_JUNGLE

	sound_environment = ENVIRONMENT_PLAIN


/area/lz_420/interior/
	sunlight_freq = 0
	interior = TRUE

	sound_environment = ENVIRONMENT_STONEROOM

/area/lz_420/interior/cave
	name = "\improper Central Caves"
	icon_state = "cave"
	tracks = TRACKS_CAVE
	random_sounds = list(
		'sound/ambient/cave_1.ogg',
		'sound/ambient/cave_2.ogg',
	)
	cheese_type = /reagent/nutrition/cheese/gruyere

	sound_environment = ENVIRONMENT_QUARRY

/area/lz_420/interior/cave/north
	name = "North Caves"
	icon_state = "blue"

	sunlight_freq = 8
	sunlight_color ="#7F3B11"

	random_sounds = list(
		'sound/ambient/lavacaves_1.ogg',
		'sound/ambient/lavacaves_2.ogg',
	)

	tracks = TRACKS_LAVA

	cheese_type = /reagent/nutrition/cheese/guava

/area/lz_420/interior/cave/south
	name = "South Caves"
	icon_state = "red"

/area/lz_420/interior/cave/east
	name = "East Caves"
	icon_state = "green"

/area/lz_420/interior/cave/west
	name = "West Caves"
	icon_state = "yellow"

/area/lz_420/interior/nexus
	name = "\improper Nexus"
	icon_state = "pink"
	sound_environment = ENVIRONMENT_STONEROOM

/area/lz_420/interior/nexus/entrance
	name = "\improper Nexus East Entrance"
	icon_state = "hanger"

/area/lz_420/interior/nexus/central
	name = "\improper Central Nexus Hallway"
	icon_state = "hall_c"

	sound_environment = ENVIRONMENT_CONCERT_HALL

/area/lz_420/interior/nexus/west
	name = "\improper West Nexus Hallway"
	icon_state = "hall_w"

	sound_environment = ENVIRONMENT_STONEROOM

/area/lz_420/interior/nexus/east
	name = "\improper East Nexus Hallway"
	icon_state = "hall_e"

	sound_environment = ENVIRONMENT_STONEROOM

/area/lz_420/interior/nexus/south
	name = "\improper South Nexus Hallway"
	icon_state = "hall_s"

	sound_environment = ENVIRONMENT_STONEROOM

/area/lz_420/interior/nexus/north
	name = "\improper North Nexus Hallway"
	icon_state = "hall_n"

	sound_environment = ENVIRONMENT_STONEROOM

/area/lz_420/interior/nexus/maint
	name = "\improper Nexus Maintenance"
	icon_state = "maint"

	sound_environment = ENVIRONMENT_BATHROOM

/area/lz_420/interior/nexus/chapel
	name = "\improper Nexus Chapel"
	icon_state = "chapel"

/area/lz_420/interior/nexus/armory
	name = "\improper Nexus Armory"
	icon_state = "armory"

/area/lz_420/interior/nexus/cargo
	name = "\improper Nexus Cargo"
	icon_state = "cargo"

/area/lz_420/interior/nexus/kitchen
	name = "\improper Nexus Kitchen"
	icon_state = "kitchen"

/area/lz_420/interior/nexus/science
	name = "\improper Nexus Science"
	icon_state = "science"

/area/lz_420/interior/nexus/garden
	name = "\improper Nexus Garden"
	icon_state = "grass"

/area/lz_420/interior/nexus/medical
	name = "\improper Nexus Medical"
	icon_state = "med"

/area/lz_420/interior/nexus/engineering
	name = "\improper Nexus Engineering"
	icon_state = "eng"

/area/lz_420/interior/nexus/wip
	name = "\improper Nexus Abandoned Area"
	icon_state = "wip"