/area/centcomm
	name = "Central Command"
	icon_state = "cmd"
	flags_area = FLAG_AREA_NO_DAMAGE | FLAG_AREA_NO_CONSTRUCTION | FLAG_AREA_NO_ROUND_INFORMATION | FLAG_AREA_TUTORIAL | FLAG_AREA_NO_EVENTS | FLAG_AREA_NO_TELEPORT | FLAG_AREA_SAVEZONE

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

	area_identifier = "Central Command"

	sound_environment = ENVIRONMENT_STONEROOM

	dynamic_lighting = TRUE

/area/centcomm/chargen
	name = "Chargen Area"
	area_identifier = "Character Generation"
	flags_area = FLAG_AREA_NO_DAMAGE | FLAG_AREA_NO_CONSTRUCTION | FLAG_AREA_NO_ROUND_INFORMATION | FLAG_AREA_TUTORIAL | FLAG_AREA_NO_EVENTS | FLAG_AREA_SAVEZONE | FLAG_AREA_SINGLEPLAYER

	sunlight_freq = 2
	sunlight_color = "#576168"


/area/debug
	name = "Debug Area"
	icon_state = "cmd"
	flags_area = FLAG_AREA_NO_ROUND_INFORMATION | FLAG_AREA_NO_EVENTS

	area_identifier = "Debug"

	sound_environment = ENVIRONMENT_STONEROOM

	requires_power = FALSE

	default_state_power_lights = ON
	default_state_power_machines = ON
	default_state_power_doors = ON

	dynamic_lighting = TRUE


/area/generation
	name = "?Generation"
	icon_state = "cmd"
	flags_area = FLAG_AREA_NO_CONSTRUCTION | FLAG_AREA_NO_ROUND_INFORMATION | FLAG_AREA_TUTORIAL | FLAG_AREA_NO_EVENTS | FLAG_AREA_SAVEZONE
	sunlight_freq = 4
	sunlight_color = "#2C4D59"
