/area/ghost/
	area_identifier = "Ghost"
	allow_ghost = TRUE
	safe_storage = TRUE //People will die a lot.
	flags_area = FLAGS_AREA_NO_TELEPORT | FLAGS_AREA_NO_CONSTRUCTION | FLAGS_AREA_NO_EVENTS
	sound_environment = ENVIRONMENT_STONEROOM

	ambient_sound = 'sound/ambient/vents_loop.ogg'

	random_sounds = list(
		'sound/ambient/maint_1.ogg',
		'sound/ambient/maint_2.ogg'
	)

/area/ghost/hall
	name = "\improper Classified Research Center - Hallway"
	icon_state = "hall"
	sound_environment = ENVIRONMENT_ALLEY

/area/ghost/hall/north
	name = "\improper Classified Research Center - North Hallway"
	icon_state = "hall_n"

/area/ghost/hall/east
	name = "\improper Classified Research Center - East Hallway"
	icon_state = "hall_e"

/area/ghost/hall/south
	name = "\improper Classified Research Center - South Hallway"
	icon_state = "hall_s"

/area/ghost/hall/west
	name = "\improper Classified Research Center - West Hallway"
	icon_state = "hall_w"

/area/ghost/hall/entrance
	name = "\improper Classified Research Center - Entrance Hallway"
	icon_state = "hall_c"

/area/ghost/maint
	name = "\improper Classified Research Center - Maint"
	icon_state = "maint"
	sound_environment = ENVIRONMENT_BATHROOM

/area/ghost/maint/north
	name = "\improper Classified Research Center - North Maintenance"
	icon_state = "maint_n"

/area/ghost/maint/east
	name = "\improper Classified Research Center - East Maintenance"
	icon_state = "maint_e"

/area/ghost/maint/south
	name = "\improper Classified Research Center - South Maintenance"
	icon_state = "maint_s"

/area/ghost/maint/west
	name = "\improper Classified Research Center - West Maintenance"
	icon_state = "maint_w"

/area/ghost/maint/central
	name = "\improper Classified Research Center - Central Maintenance"
	icon_state = "disposals"

/area/ghost/medical
	name = "\improper Classified Research Center - Medical"
	icon_state = "med"


/area/ghost/bathrooms
	name = "\improper Classified Research Center - Bathrooms"
	icon_state = "bath"

	sound_environment = ENVIRONMENT_ROOM

/area/ghost/bathrooms/male
	name = "\improper Classified Research Center - Male Restroom"
	color = "blue"

/area/ghost/bathrooms/female
	name = "\improper Classified Research Center - Female Restroom"
	color = "red"

/area/ghost/cafe
	name = "\improper Classified Research Center - Cafe"
	icon_state = "cafe"


/area/ghost/science
	name = "\improper Classified Research Center - Science"
	icon_state = "science"

/area/ghost/command
	name = "\improper Classified Research Center - Command"
	icon_state = "brief"


/area/ghost/engineering
	name = "\improper Classified Research Center - Engineering"
	icon_state = "eng"

	sound_environment = ENVIRONMENT_STONEROOM