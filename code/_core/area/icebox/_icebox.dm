/area/icebox/
	name = "\improper Icebox"
	trackable = TRUE
	area_identifier = "Mission"

	sound_environment = ENVIRONMENT_ROOM

/area/icebox/exterior
	name = "\improper Icebox Exterior"
	icon_state = "snow"
	weather = WEATHER_SNOW
	ambient_temperature = T0C - 20
	hazard = "cold"
	sunlight_freq = 8
	sunlight_color = "#898989"

	cheese_type = /reagent/nutrition/cheese/raclette

	tracks = TRACKS_MOUNTAIN

	sound_environment = ENVIRONMENT_FOREST

/area/icebox/interior/
	interior = TRUE

	sound_environment = ENVIRONMENT_ROOM

/area/icebox/interior/caves
	name = "\improper Unexplored Caves"
	icon_state = "cave"
	tracks = TRACKS_CAVE
	random_sounds = list(
		'sound/ambient/cave_1.ogg',
		'sound/ambient/cave_2.ogg',
	)
	cheese_type = /reagent/nutrition/cheese/gruyere

	sound_environment = ENVIRONMENT_CAVE

/area/icebox/interior/syndicate_shuttle
	name = "\improper UNKNOWN SHIP"
	icon_state = "syndicate"

/area/icebox/interior/station
	name = "\improper Icebox Station Interior"
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


/area/icebox/interior/station/hall
	name = "\improper Icebox Hallway"
	icon_state = "hall"

	sound_environment = ENVIRONMENT_HALLWAY

/area/icebox/interior/station/hall/north
	name = "\improper Icebox North Hallway"
	icon_state = "hall_n"

/area/icebox/interior/station/hall/east
	name = "\improper Icebox East Hallway"
	icon_state = "hall_e"

/area/icebox/interior/station/hall/south
	name = "\improper Icebox South Hallway"
	icon_state = "hall_s"

/area/icebox/interior/station/hall/west
	name = "\improper Icebox West Hallway"
	icon_state = "hall_w"

/area/icebox/interior/station/hall/central
	name = "\improper Icebox Central Primary Hallway"
	icon_state = "hall_c"

/area/icebox/interior/station/hall/dorms
	name = "\improper Icebox Dorms Hallway"
	icon_state = "dorms_hall"

/area/icebox/interior/station/bathrooms
	name = "\improper Icebox Bathrooms"
	icon_state = "bath"

	sound_environment = ENVIRONMENT_BATHROOM

/area/icebox/interior/station/hydroponics
	name = "\improper Icebox Hydroponics"
	icon_state = "hydro"

/area/icebox/interior/station/cafe
	name = "\improper Icebox Cafe"
	icon_state = "cafe"
	safe_storage = TRUE

/area/icebox/interior/station/cafe/kitchen
	name = "\improper Icebox Kitchen"
	icon_state = "kitchen"

/area/icebox/interior/station/cafe/bar
	name = "\improper Icebox Bar"
	icon_state = "bar"

/area/icebox/interior/station/dressing
	name = "\improper Icebox Dressing Room"
	icon_state = "dressing"

/area/icebox/interior/station/dorm
	name = "\improper Icebox Dorm"
	icon_state = "dorm"

/area/icebox/interior/station/help_desk
	name = "\improper Icebox Help Desk"
	icon_state = "help"

/area/icebox/interior/station/cloning
	name = "\improper Icebox Cloning"
	icon_state = "clone"

/area/icebox/interior/station/science
	name = "\improper Icebox Science"
	icon_state = "science"

/area/icebox/interior/station/cryo
	name = "\improper Icebox Cryogenic Storage"
	icon_state = "cryo"

/area/icebox/interior/station/arrivals
	name = "\improper Icebox Arrivals Dock"
	icon_state = "ariv"

	sound_environment = ENVIRONMENT_HANGAR

/area/icebox/interior/station/chapel
	name = "\improper Icebox Chapel"
	icon_state = "chapel"

/area/icebox/interior/station/library
	name = "\improper Icebox Library"
	icon_state = "library"

/area/icebox/interior/station/engineering
	name = "\improper Icebox Engineering"
	icon_state = "eng"

/area/icebox/interior/station/medical
	name = "\improper Icebox Medical"
	icon_state = "med"

/area/icebox/interior/station/medical/chemistry
	name = "\improper Icebox Chemistry"
	icon_state = "chem"

/area/icebox/interior/station/briefing
	name = "\improper Icebox Briefing"
	icon_state = "brief"

/area/icebox/interior/station/armory
	name = "\improper Icebox Armory"
	icon_state = "armory"


/area/icebox/interior/station/hanger
	name = "\improper Icebox Hanger"
	icon_state = "hanger"

	sound_environment = ENVIRONMENT_HANGAR

/area/icebox/interior/station/cargo
	name = "\improper Icebox Cargo"
	icon_state = "cargo"

/area/icebox/interior/station/command
	name = "\improper Icebox Command"
	icon_state = "cmd"

/area/icebox/interior/station/maint
	name = "\improper Icebox Maint"
	icon_state = "maint"
	ambient_sound = 'sound/ambient/vents_loop.ogg'

	random_sounds = list(
		'sound/ambient/maint_1.ogg',
		'sound/ambient/maint_2.ogg'
	)

	sound_environment = ENVIRONMENT_ALLEY

/area/icebox/interior/station/maint/north
	name = "\improper Icebox North Maintenance"
	icon_state = "maint_n"

/area/icebox/interior/station/maint/east
	name = "\improper Icebox East Maintenance"
	icon_state = "maint_e"

/area/icebox/interior/station/maint/south
	name = "\improper Icebox South Maintenance"
	icon_state = "maint_s"

/area/icebox/interior/station/maint/west
	name = "\improper Icebox West Maintenance"
	icon_state = "maint_w"

/area/icebox/interior/station/maint/disposals
	name = "\improper Icebox Disposals Maintenance"
	icon_state = "disposals"