/area/dungeon/z_00
	name = "\improper Level 0 - Surface Above"
	icon_state = "red"

	flags_area = FLAGS_AREA_NO_TELEPORT | FLAGS_AREA_NO_DAMAGE | FLAGS_AREA_NO_CONSTRUCTION | FLAGS_AREA_NO_EVENTS

/area/dungeon/z_01
	name = "\improper Level 1 - Surface Forrest"
	icon_state = "forrest"
	cheese_type = /reagent/nutrition/cheese/cheddar
	sunlight_freq = 8
	sunlight_color = "#CCB06A"

	tracks = TRACKS_FOREST

	sound_environment = ENVIRONMENT_PLAIN


/area/dungeon/z_02
	name = "\improper Level 2 - Deep Jungle"
	icon_state = "red"

	random_sounds = list(
		'sound/ambient/ambiruin_1.ogg',
		'sound/ambient/ambiruin_2.ogg',
		'sound/ambient/ambiruin_3.ogg',
		'sound/ambient/ambiruin_4.ogg',
		'sound/ambient/ambiruin_5.ogg',
		'sound/ambient/ambiruin_6.ogg',
		'sound/ambient/ambiruin_7.ogg'
	)

	tracks = TRACKS_JUNGLE

	cheese_type = /reagent/nutrition/cheese/guava

	sound_environment = ENVIRONMENT_QUARRY