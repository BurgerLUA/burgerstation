/area/ghost/
	area_identifier = "Ghost"
	allow_ghost = TRUE
	safe_storage = TRUE //People will die a lot.
	flags_area = FLAGS_AREA_NO_TELEPORT | FLAGS_AREA_NO_DAMAGE | FLAGS_AREA_NO_CONSTRUCTION | FLAGS_AREA_NO_EVENTS
	sound_environment = ENVIRONMENT_STONEROOM

	ambient_sound = 'sound/ambient/vents_loop.ogg'

	random_sounds = list(
		'sound/ambient/maint_1.ogg',
		'sound/ambient/maint_2.ogg'
	)

/area/ghost/hall
	name = "\improper Hallway"
	icon_state = "hall"
	sound_environment = ENVIRONMENT_ALLEY

/area/ghost/hall/north
	name = "\improper North Hallway"
	icon_state = "hall_n"

/area/ghost/hall/east
	name = "\improper East Hallway"
	icon_state = "hall_e"

/area/ghost/hall/south
	name = "\improper South Hallway"
	icon_state = "hall_s"

/area/ghost/hall/west
	name = "\improper West Hallway"
	icon_state = "hall_w"

/area/ghost/hall/entrance
	name = "\improper Entrance Hallway"
	icon_state = "hall_c"

/area/ghost/maint
	name = "\improper Maint"
	icon_state = "maint"
	sound_environment = ENVIRONMENT_BATHROOM

/area/ghost/maint/north
	name = "\improper North Maintenance"
	icon_state = "maint_n"

/area/ghost/maint/east
	name = "\improper East Maintenance"
	icon_state = "maint_e"

/area/ghost/maint/south
	name = "\improper South Maintenance"
	icon_state = "maint_s"

/area/ghost/maint/west
	name = "\improper West Maintenance"
	icon_state = "maint_w"

/area/ghost/maint/central
	name = "\improper Central Maintenance"
	icon_state = "disposals"

/area/ghost/medical
	name = "\improper Medical"
	icon_state = "med"


/area/ghost/bathrooms
	name = "\improper Bathrooms"
	icon_state = "bath"

	sound_environment = ENVIRONMENT_ROOM

/area/ghost/bathrooms/male
	name = "\improper Male Restroom"
	color = "blue"

/area/ghost/bathrooms/female
	name = "\improper Female Restroom"
	color = "red"

/area/ghost/cafe
	name = "\improper Cafe"
	icon_state = "cafe"


/area/ghost/science
	name = "\improper Science"
	icon_state = "science"

/area/ghost/command
	name = "\improper Command"
	icon_state = "brief"


/area/ghost/engineering
	name = "\improper Engineering"
	icon_state = "eng"

	sound_environment = ENVIRONMENT_STONEROOM
