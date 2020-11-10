/area/icebox/
	name = "\improper Icebox"
	trackable = TRUE
	area_identifier = "Mission"

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

/area/icebox/interior
	name = "\improper Icebox Interior"
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



/area/icebox/interior/hall
	name = "\improper Icebox Hallway"
	icon_state = "hall"

/area/icebox/interior/hall/north
	name = "\improper Icebox North Hallway"
	icon_state = "hall_n"

/area/icebox/interior/hall/east
	name = "\improper Icebox East Hallway"
	icon_state = "hall_e"

/area/icebox/interior/hall/south
	name = "\improper Icebox South Hallway"
	icon_state = "hall_s"

/area/icebox/interior/hall/west
	name = "\improper Icebox West Hallway"
	icon_state = "hall_w"

/area/icebox/interior/hall/central
	name = "\improper Icebox Central Primary Hallway"
	icon_state = "hall_c"

/area/icebox/interior/hall/dorms
	name = "\improper Icebox Dorms Hallway"
	icon_state = "dorms_hall"

/area/icebox/interior/bathrooms
	name = "\improper Icebox Bathrooms"
	icon_state = "bath"

/area/icebox/interior/hydroponics
	name = "\improper Icebox Hydroponics"
	icon_state = "hydro"

/area/icebox/interior/cafe
	name = "\improper Icebox Cafe"
	icon_state = "cafe"
	safe_storage = TRUE

/area/icebox/interior/cafe/kitchen
	name = "\improper Icebox Kitchen"
	icon_state = "kitchen"

/area/icebox/interior/cafe/bar
	name = "\improper Icebox Bar"
	icon_state = "bar"

/area/icebox/interior/dressing
	name = "\improper Icebox Dressing Room"
	icon_state = "dressing"

/area/icebox/interior/dorm
	name = "\improper Icebox Dorm"
	icon_state = "dorm"

/area/icebox/interior/help_desk
	name = "\improper Icebox Help Desk"
	icon_state = "help"

/area/icebox/interior/cloning
	name = "\improper Icebox Cloning"
	icon_state = "clone"

/area/icebox/interior/science
	name = "\improper Icebox Science"
	icon_state = "science"

/area/icebox/interior/cryo
	name = "\improper Icebox Cryogenic Storage"
	icon_state = "cryo"

/area/icebox/interior/arrivals
	name = "\improper Icebox Arrivals Dock"
	icon_state = "ariv"

/area/icebox/interior/chapel
	name = "\improper Icebox Chapel"
	icon_state = "chapel"

/area/icebox/interior/library
	name = "\improper Icebox Library"
	icon_state = "library"

/area/icebox/interior/engineering
	name = "\improper Icebox Engineering"
	icon_state = "eng"

/area/icebox/interior/medical
	name = "\improper Icebox Medical"
	icon_state = "med"

/area/icebox/interior/medical/chemistry
	name = "\improper Icebox Chemistry"
	icon_state = "chem"

/area/icebox/interior/briefing
	name = "\improper Icebox Briefing"
	icon_state = "brief"

/area/icebox/interior/armory
	name = "\improper Icebox Armory"
	icon_state = "armory"


/area/icebox/interior/hanger
	name = "\improper Icebox Hanger"
	icon_state = "hanger"

/area/icebox/interior/cargo
	name = "\improper Icebox Cargo"
	icon_state = "cargo"

/area/icebox/interior/command
	name = "\improper Icebox Command"
	icon_state = "cmd"

/area/icebox/interior/maint
	name = "\improper Icebox Maint"
	icon_state = "maint"
	ambient_sound = 'sound/ambient/vents_loop.ogg'

	random_sounds = list(
		'sound/ambient/maint_1.ogg',
		'sound/ambient/maint_2.ogg'
	)

/area/icebox/interior/maint/north
	name = "\improper Icebox North Maintenance"
	icon_state = "maint_n"

/area/icebox/interior/maint/east
	name = "\improper Icebox East Maintenance"
	icon_state = "maint_e"

/area/icebox/interior/maint/south
	name = "\improper Icebox South Maintenance"
	icon_state = "maint_s"

/area/icebox/interior/maint/west
	name = "\improper Icebox West Maintenance"
	icon_state = "maint_w"

/area/icebox/interior/maint/disposals
	name = "\improper Icebox Disposals Maintenance"
	icon_state = "disposals"