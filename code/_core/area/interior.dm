/area/interior/

/area/interior/roof
	name = "roof"
	icon_state = "roof"

/area/interior/cave
	name = "cave"
	icon_state = "cave"
	random_sounds = list(
		'sounds/ambient/cave_1.ogg',
		'sounds/ambient/cave_2.ogg',
	)

/area/interior/syndicate_base
	name = "syndicate base"
	icon_state = "syndie"

/area/interior/station
	name = "Central Command"
	icon_state = "cmd"
	flags_area = FLAGS_AREA_NO_DAMAGE | FLAGS_AREA_NO_CONSTRUCTION

/area/interior/station/singleplayer
	name = "Home"
	icon_state = "solo"
	flags_area = FLAGS_AREA_NO_DAMAGE | FLAGS_AREA_NO_CONSTRUCTION | FLAGS_AREA_SINGLEPLAYER

/area/interior/ship
	name = "\improper NSS Burger"
	icon_state = "ship"
	flags_area = FLAGS_AREA_NO_DAMAGE | FLAGS_AREA_NO_CONSTRUCTION | FLAGS_AREA_ANNOUNCEMENTS

	ambient_sound = 'sounds/ambient/station_loop.ogg'
	random_sounds = list(
		'sounds/ambient/station_1.ogg',
		'sounds/ambient/station_2.ogg',
		'sounds/ambient/station_3.ogg',
		'sounds/ambient/station_4.ogg',
		'sounds/ambient/station_5.ogg',
		'sounds/ambient/station_6.ogg',
		'sounds/ambient/station_7.ogg',
		'sounds/ambient/station_8.ogg',
		'sounds/ambient/station_9.ogg',
		'sounds/ambient/station_10.ogg',
		'sounds/ambient/station_11.ogg',
		'sounds/ambient/station_12.ogg'
	)

/area/interior/ship/hall
	name = "\improper Hallway"
	icon_state = "hall"

/area/interior/ship/hall/north
	name = "\improper North Hallway"
	icon_state = "hall_n"

/area/interior/ship/hall/east
	name = "\improper East Hallway"
	icon_state = "hall_e"

/area/interior/ship/hall/south
	name = "\improper South Hallway"
	icon_state = "hall_s"

/area/interior/ship/hall/west
	name = "\improper West Hallway"
	icon_state = "hall_w"

/area/interior/ship/hall/dorms
	name = "\improper Dorms Hallway"
	icon_state = "dorms_hall"

/area/interior/ship/bathrooms
	name = "\improper Bathrooms"
	icon_state = "bath"

/area/interior/ship/kitchen
	name = "\improper Cafe"
	icon_state = "cafe"

/area/interior/ship/dorm
	name = "\improper Dorm"
	icon_state = "dorm"
	flags_area = FLAGS_AREA_NO_DAMAGE | FLAGS_AREA_NO_CONSTRUCTION | FLAGS_AREA_ANNOUNCEMENTS | FLAGS_AREA_SAVEZONE

/area/interior/ship/cloning
	name = "\improper Cloning"
	icon_state = "clone"

/area/interior/ship/cryo
	name = "\improper Cryogenic Storage"
	icon_state = "cryo"

/area/interior/ship/dock/arrivals
	name = "\improper Arrivals Dock"
	icon_state = "ariv"

/area/interior/ship/engineering
	name = "\improper Engineering"
	icon_state = "eng"

/area/interior/ship/medical
	name = "\improper Medical"
	icon_state = "med"

/area/interior/ship/medical/chemistry
	name = "\improper Chemistry"
	icon_state = "chem"

/area/interior/ship/briefing
	name = "\improper Briefing"
	icon_state = "brief"

/area/interior/ship/armory
	name = "\improper Armory"
	icon_state = "arm"

/area/interior/ship/hanger
	name = "\improper Hanger"
	icon_state = "hanger"

/area/interior/ship/maint
	name = "\improper Maint"
	icon_state = "maint"
	ambient_sound = 'sounds/ambient/vents_loop.ogg'

	random_sounds = list(
		'sounds/ambient/maintenance.ogg'
	)