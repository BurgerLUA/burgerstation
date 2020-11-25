/area/box/
	name = "\improper B-0X"
	trackable = TRUE
	area_identifier = "Mission"

	sound_environment = ENVIRONMENT_ROOM

/area/box/exterior
	name = "\improper B-0X Exterior"
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

	sound_environment = ENVIRONMENT_FOREST

/area/box/interior/
	interior = TRUE

	sound_environment = ENVIRONMENT_ROOM

/area/box/interior/caves
	name = "\improper Unexplored Caves"
	icon_state = "cave"
	tracks = TRACKS_CAVE
	random_sounds = list(
		'sound/ambient/cave_1.ogg',
		'sound/ambient/cave_2.ogg',
	)
	cheese_type = /reagent/nutrition/cheese/gruyere

	sound_environment = ENVIRONMENT_CAVE

/area/box/interior/syndicate_shuttle
	name = "\improper UNKNOWN SHIP"
	icon_state = "syndicate"

/area/box/interior/station
	name = "\improper B-0X Station Interior"
	icon_state = "ship"

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

	sound_environment = ENVIRONMENT_ROOM


/area/box/interior/station/hall
	name = "\improper B-0X Hallway"
	icon_state = "hall"

	sound_environment = ENVIRONMENT_HALLWAY

/area/box/interior/station/hall/north
	name = "\improper B-0X North Hallway"
	icon_state = "hall_n"

/area/box/interior/station/hall/east
	name = "\improper B-0X East Hallway"
	icon_state = "hall_e"

/area/box/interior/station/hall/south
	name = "\improper B-0X South Hallway"
	icon_state = "hall_s"

/area/box/interior/station/hall/west
	name = "\improper B-0X West Hallway"
	icon_state = "hall_w"

/area/box/interior/station/hall/central
	name = "\improper B-0X Central Primary Hallway"
	icon_state = "hall_c"

/area/box/interior/station/hall/dorms
	name = "\improper B-0X Dorms Hallway"
	icon_state = "dorms_hall"

/area/box/interior/station/bathrooms
	name = "\improper B-0X Bathrooms"
	icon_state = "bath"

	sound_environment = ENVIRONMENT_BATHROOM

/area/box/interior/station/hydroponics
	name = "\improper B-0X Hydroponics"
	icon_state = "hydro"

/area/box/interior/station/cafe
	name = "\improper B-0X Cafe"
	icon_state = "cafe"
	safe_storage = TRUE

/area/box/interior/station/cafe/kitchen
	name = "\improper B-0X Kitchen"
	icon_state = "kitchen"

/area/box/interior/station/cafe/bar
	name = "\improper B-0X Bar"
	icon_state = "bar"

/area/box/interior/station/dressing
	name = "\improper B-0X Dressing Room"
	icon_state = "dressing"

/area/box/interior/station/dorm
	name = "\improper B-0X Dorm"
	icon_state = "dorm"

/area/box/interior/station/help_desk
	name = "\improper B-0X Help Desk"
	icon_state = "help"

/area/box/interior/station/cloning
	name = "\improper B-0X Cloning"
	icon_state = "clone"

/area/box/interior/station/science
	name = "\improper B-0X Science"
	icon_state = "science"

/area/box/interior/station/cryo
	name = "\improper B-0X Cryogenic Storage"
	icon_state = "cryo"

/area/box/interior/station/arrivals
	name = "\improper B-0X Arrivals Dock"
	icon_state = "ariv"

	sound_environment = ENVIRONMENT_HANGAR

/area/box/interior/station/chapel
	name = "\improper B-0X Chapel"
	icon_state = "chapel"

/area/box/interior/station/library
	name = "\improper B-0X Library"
	icon_state = "library"

/area/box/interior/station/engineering
	name = "\improper B-0X Engineering"
	icon_state = "eng"

/area/box/interior/station/medical
	name = "\improper B-0X Medical"
	icon_state = "med"

/area/box/interior/station/medical/chemistry
	name = "\improper B-0X Chemistry"
	icon_state = "chem"

/area/box/interior/station/briefing
	name = "\improper B-0X Briefing"
	icon_state = "brief"

/area/box/interior/station/armory
	name = "\improper B-0X Armory"
	icon_state = "armory"


/area/box/interior/station/hanger
	name = "\improper B-0X Hanger"
	icon_state = "hanger"

	sound_environment = ENVIRONMENT_HANGAR

/area/box/interior/station/cargo
	name = "\improper B-0X Cargo"
	icon_state = "cargo"

/area/box/interior/station/command
	name = "\improper B-0X Command"
	icon_state = "cmd"

/area/box/interior/station/maint
	name = "\improper B-0X Maint"
	icon_state = "maint"
	ambient_sound = 'sound/ambient/vents_loop.ogg'

	random_sounds = list(
		'sound/ambient/maint_1.ogg',
		'sound/ambient/maint_2.ogg'
	)

	sound_environment = ENVIRONMENT_ALLEY

/area/box/interior/station/maint/north
	name = "\improper B-0X North Maintenance"
	icon_state = "maint_n"

/area/box/interior/station/maint/east
	name = "\improper B-0X East Maintenance"
	icon_state = "maint_e"

/area/box/interior/station/maint/south
	name = "\improper B-0X South Maintenance"
	icon_state = "maint_s"

/area/box/interior/station/maint/west
	name = "\improper B-0X West Maintenance"
	icon_state = "maint_w"

/area/box/interior/station/maint/disposals
	name = "\improper B-0X Disposals Maintenance"
	icon_state = "disposals"