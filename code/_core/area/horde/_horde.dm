/area/horde/

	name = "Error"

	dynamic_lighting = TRUE

	map_color_r = rgb(255,0,0,255)
	map_color_g = rgb(0,255,0,255)
	map_color_b = rgb(25,25,200,255)
	map_color_a = rgb(0,0,0,255)


/area/horde/space
	name = "space"
	icon_state = "green"


/area/horde/station
	name = "Lobby"
	icon_state = "safe"
	safe = FALSE
	station = FALSE

/area/horde/station/cryo
	name = "crew cabin"

/area/horde/station/bathroom
	name = "Bathroom"
	icon_state = "safe2"
	singleplayer = TRUE

/area/horde/exterior
	name = "Sky"
	icon_state = "green"

	dynamic_sunlight_enabled = TRUE

	sunlight_freq = 6
	desired_light_range = 6
	desired_light_power = 1
	desired_light_color = "#3F3B28"

/area/horde/roof
	name = "Roof"
	icon_state = "red"

/area/horde/spawnpoint
	name = "Spawn"
	icon_state = "blue"