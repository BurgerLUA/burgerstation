/area/hellscape/exterior/
	sound_environment = ENVIRONMENT_PLAIN

/area/hellscape/exterior/jungle
	name = "Jungle"
	icon_state = "jungle"
	weather = WEATHER_RAIN
	ambient_temperature = T0C + 40

	sunlight_freq = 8
	sunlight_color = "#618971"

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

/area/hellscape/exterior/jungle/north
	name = "North Jungle"
	icon_state = "jungle_north"

/area/hellscape/exterior/jungle/south
	name = "South Jungle"
	icon_state = "jungle_south"

/area/hellscape/exterior/death_plains
	name = "Death Plains"
	icon_state = "meat"

/area/hellscape/interior/caves
	name = "Caves"
	icon_state = "cave"

	sound_environment = ENVIRONMENT_QUARRY

/area/hellscape/interior/caves/watersource
	name = "Watersource Caves"
	icon_state = "pink"

	sound_environment = ENVIRONMENT_CAVE

/area/hellscape/interior/caves/hive
	name = "\improper Hive"
	icon_state = "hive"

	sound_environment = ENVIRONMENT_CAVE

/area/hellscape/interior/caves/ancient
	name = "Caves of the Ancient"
	icon_state = "disposals"

	sound_environment = ENVIRONMENT_CAVE

/area/hellscape/interior/caves/crash
	name = "Crashed Ship"
	icon_state = "orange"

	sound_environment = ENVIRONMENT_CAVE

/area/hellscape/interior/caves/hellchamber
	name = "Lava Caves Hellchamber"
	icon_state = "volcanic"


/area/hellscape/interior/caves/lava_lake
	name = "Eastern Lava Lake"
	icon_state = "yellow"

	sound_environment = ENVIRONMENT_CAVE

/area/hellscape/interior/caves/containment
	name = "Containment Cave"
	icon_state = "cyan"

	sound_environment = ENVIRONMENT_CAVE

/area/hellscape/interior/caves/broodmother
	name = "Broodmother's Nest"
	icon_state = "green"

	sound_environment = ENVIRONMENT_CAVE

/area/hellscape/interior/caves/ashwalker_village
	name = "Ashwalker's Village"
	icon_state = "village"

/area/hellscape/interior/caves/rev
	name = "Revolutionary Base Outskirts"
	icon_state = "blue"

/area/hellscape/interior/caves/crab
	name = "Crab Cave"
	icon_state = "orange"

/area/hellscape/interior/caves/syndicate
	name = "Syndicate Base Outskirts"
	icon_state = "blue"

/area/hellscape/interior/pirate_landing
	name = "Pirate's Landing"
	icon_state = "lagoon"

	sound_environment = ENVIRONMENT_CONCERT_HALL

/area/hellscape/interior/rev
	name = "Revolutionary Base"
	icon_state = "library"

	sound_environment = ENVIRONMENT_STONEROOM

/area/hellscape/interior/supermatter
	name = "Supermatter Substation"
	icon_state = "eng"

	sound_environment = ENVIRONMENT_STONEROOM

/area/hellscape/interior/syndicate
	name = "Syndicate Base"
	icon_state = "syndicate"

	sound_environment = ENVIRONMENT_STONEROOM

/area/hellscape/interior/syndicate/aux
	name = "Syndicate Aux Base"
	icon_state = "syndicate"

/area/hellscape/interior/syndicate/canman
	name = "Syndicate Testing Chambers"
	icon_state = "syndicate"