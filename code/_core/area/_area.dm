/area/
	name = "AREA ERROR"
	icon = 'icons/debug/areas.dmi'
	icon_state = ""
	layer = LAYER_AREA
	invisibility = 101

	luminosity = 2

	var/flags_area = FLAG_AREA_NONE

	var/sound_environment = ENVIRONMENT_GENERIC

	var/safe = FALSE //Enable or disable shooting people.

	var/map_color_r = rgb(51,13,13)
	var/map_color_g = rgb(26,77,51)
	var/map_color_b = rgb(26,26,102)
	var/map_color_a = rgb(0,0,0)

/area/on_enter(var/atom/movable/enterer)
	if(enterer.area != src)
		if(enterer.area)
			enterer.area.on_exit(enterer)
		enterer.area = src
		return TRUE

	return FALSE

/area/on_exit(var/atom/movable/enterer)
	return TRUE

