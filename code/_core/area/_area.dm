/area/
	name = "AREA ERROR"
	icon = 'icons/debug/areas.dmi'
	icon_state = ""
	layer = LAYER_AREA
	plane = PLANE_AREA
	invisibility = 101

	luminosity = 2

	var/flags_area = FLAG_AREA_NONE

	var/sound_environment = ENVIRONMENT_GENERIC

	var/safe = FALSE //Enable or disable shooting people.

	var/map_color_r = rgb(255,0,0,255)
	var/map_color_g = rgb(0,255,0,255)
	var/map_color_b = rgb(0,0,255,255)
	var/map_color_a = rgb(0,0,0,255)


	var/list/ambient_sounds = list()
	var/list/random_sounds = list()

/area/on_enter(var/atom/movable/enterer)

	if(enterer.area != src)
		if(enterer.area)
			enterer.area.on_exit(enterer)
		enterer.area = src

		if(is_mob(enterer))
			var/mob/M = enterer
			if(M.client)
				M.client.update_lighting()

		return TRUE

	return FALSE

/area/on_exit(var/atom/movable/enterer)
	return TRUE

