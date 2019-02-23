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


	var/ambient_sound
	var/list/random_sounds = list()

/area/Entered(var/atom/movable/enterer,var/atom/old_loc)

	if(enterer.area != src)
		if(enterer.area && is_mob(enterer))
			var/mob/M = enterer
			if(M.client)
				if(ambient_sound && (!enterer.area || enterer.area.ambient_sound != ambient_sound))
					play_ambient_sound(ambient_sound,enterer,environment = sound_environment,loop = TRUE)

		enterer.area = src

		if(is_mob(enterer))
			var/mob/M = enterer
			if(M.client)
				M.client.update_lighting()

		return TRUE

	return FALSE

/area/Exited(var/atom/movable/exiter,var/atom/old_loc)
	return TRUE

