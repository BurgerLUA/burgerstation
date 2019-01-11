/area/
	name = "AREA ERROR"
	icon = 'icons/debug/areas.dmi'
	icon_state = ""
	layer = LAYER_AREA
	invisibility = 101

	luminosity = 2

	var/flags_area = FLAG_AREA_NONE

	var/sound_environment = ENVIRONMENT_GENERIC

/area/on_enter(var/atom/movable/enterer)
	if(enterer.area != src)
		if(enterer.area)
			enterer.area.on_exit(enterer)
		enterer.area = src
		return TRUE

	return FALSE

/area/on_exit(var/atom/movable/enterer)
	return TRUE
