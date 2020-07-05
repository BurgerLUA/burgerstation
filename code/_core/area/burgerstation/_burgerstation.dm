/area/burgerstation
	name = "\improper NSS Burger"
	icon_state = "ship"
	flags_area = FLAGS_AREA_NO_DAMAGE | FLAGS_AREA_NO_CONSTRUCTION

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

/area/burgerstation/hall
	name = "\improper Hallway"
	icon_state = "hall"

/area/burgerstation/hall/north
	name = "\improper North Hallway"
	icon_state = "hall_n"

/area/burgerstation/hall/east
	name = "\improper East Hallway"
	icon_state = "hall_e"

/area/burgerstation/hall/south
	name = "\improper South Hallway"
	icon_state = "hall_s"

/area/burgerstation/hall/west
	name = "\improper West Hallway"
	icon_state = "hall_w"

/area/burgerstation/hall/central
	name = "\improper Central Primary Hallway"
	icon_state = "hall_c"

/area/burgerstation/hall/dorms
	name = "\improper Dorms Hallway"
	icon_state = "dorms_hall"

/area/burgerstation/bathrooms
	name = "\improper Bathrooms"
	icon_state = "bath"

/area/burgerstation/cafe
	name = "\improper Cafe"
	icon_state = "cafe"
	safe_storage = TRUE

/area/burgerstation/cafe/kitchen
	name = "\improper Kitchen"
	icon_state = "kitchen"

/area/burgerstation/cafe/bar
	name = "\improper Bar"
	icon_state = "bar"

/area/burgerstation/dressing
	name = "\improper Dressing Room"
	icon_state = "dressing"

/area/burgerstation/dorm
	name = "\improper Dorm"
	icon_state = "dorm"
	flags_area = FLAGS_AREA_NO_DAMAGE | FLAGS_AREA_NO_CONSTRUCTION | FLAGS_AREA_SAVEZONE

/area/burgerstation/help_desk
	name = "\improper Help Desk"
	icon_state = "help"

/area/burgerstation/cloning
	name = "\improper Cloning"
	icon_state = "clone"

/area/burgerstation/science
	name = "\improper Science"
	icon_state = "science"

/area/burgerstation/cryo
	name = "\improper Cryogenic Storage"
	icon_state = "cryo"
	flags_area = FLAGS_AREA_NO_DAMAGE | FLAGS_AREA_NO_CONSTRUCTION | FLAGS_AREA_SAVEZONE

/area/burgerstation/arrivals
	name = "\improper Arrivals Dock"
	icon_state = "ariv"

/area/burgerstation/chapel
	name = "\improper Chapel"
	icon_state = "chapel"

/area/burgerstation/library
	name = "\improper Library"
	icon_state = "library"

/area/burgerstation/engineering
	name = "\improper Engineering"
	icon_state = "eng"

/area/burgerstation/medical
	name = "\improper Medical"
	icon_state = "med"

/area/burgerstation/medical/chemistry
	name = "\improper Chemistry"
	icon_state = "chem"

/area/burgerstation/briefing
	name = "\improper Briefing"
	icon_state = "brief"

/area/burgerstation/armory
	name = "\improper Armory"
	icon_state = "armory"

/area/burgerstation/armory/special
	name = "\improper Armory - Special Operations"
	icon_state = "armory_special"

/area/burgerstation/armory/shooting_range
	name = "\improper Shooting Range"
	icon_state = "shooting_range"

/area/burgerstation/hanger
	name = "\improper Hanger"
	icon_state = "hanger"

/area/burgerstation/cargo
	name = "\improper Cargo"
	icon_state = "cargo"
	safe_storage = TRUE

/area/burgerstation/maint
	name = "\improper Maint"
	icon_state = "maint"
	ambient_sound = 'sound/ambient/vents_loop.ogg'

	random_sounds = list(
		'sound/ambient/maint_1.ogg',
		'sound/ambient/maint_2.ogg'
	)

/area/burgerstation/maint/north
	name = "\improper North Maintenance"
	icon_state = "maint_n"

/area/burgerstation/maint/east
	name = "\improper East Maintenance"
	icon_state = "maint_e"

/area/burgerstation/maint/south
	name = "\improper South Maintenance"
	icon_state = "maint_s"

/area/burgerstation/maint/west
	name = "\improper West Maintenance"
	icon_state = "maint_w"

/area/burgerstation/maint/disposals
	name = "\improper Disposals Maintenance"
	icon_state = "disposals"


/area/burgerstation/pvp
	name = "ERROR"
	icon_state = "pvp"
	flags_area = FLAGS_AREA_NO_DAMAGE | FLAGS_AREA_NO_CONSTRUCTION | FLAG_AREA_NO_LOYALTY
