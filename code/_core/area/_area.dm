/var/list/area/areas = list()

/area/
	name = "AREA ERROR"
	id = null
	icon = 'icons/area/area.dmi'
	icon_state = ""
	layer = LAYER_AREA
	plane = PLANE_AREA
	invisibility = 101

	mouse_opacity = 0

	var/flags_area = FLAG_AREA_NONE

	var/sound_environment = ENVIRONMENT_GENERIC

	var/safe = FALSE //Enable or disable shooting people.

	var/map_color_r = rgb(255,0,0,255)
	var/map_color_g = rgb(0,255,0,255)
	var/map_color_b = rgb(0,0,255,255)
	var/map_color_a = rgb(0,0,0,255)

	var/ambient_sound
	var/list/random_sounds = list()
	var/list/tracks = list()

	luminosity           = 2
	var/dynamic_lighting = FALSE

	var/level_multiplier = 1 //Adjust the level multiplier for mobs that spawn here using spawners.

	var/area_light_power = 0

/area/New()
	. = ..()
	global.areas += src
	if(dynamic_lighting)
		luminosity = 0

/area/Entered(var/atom/movable/enterer,var/atom/old_loc)

	if(safe && is_player(enterer))
		var/mob/living/advanced/player/P = enterer
		P.spawn_protection = SECONDS_TO_DECISECONDS(SPAWN_PROTECTION_TIME)

	if(enterer.area != src)

		if(is_mob(enterer))
			var/mob/M = enterer
			if(M.client)
				if(ambient_sound && (!enterer.area || enterer.area.ambient_sound != ambient_sound))
					play_ambient_sound(ambient_sound,enterer,environment = sound_environment,loop = TRUE)

				if(length(tracks) && !M.client.savedata.loaded_data["tutorial"] && (!enterer.area || enterer.area.id != src.id))
					play_music_track(pick(tracks),M.client)

			if(is_living(enterer) && enterer.area)
				var/mob/living/L = M
				if(enterer.area.safe && !src.safe) //Leaving a safezone
					L.to_chat(span("notice","You are leaving a safezone. You will be protected for an additional [SPAWN_PROTECTION_TIME] seconds before being able to attack and be attacked again."))
				else if(!enterer.area.safe && src.safe) //Entering a safezone
					L.to_chat(span("notice","You are now entering a safezone. You cannot attack or be attacked by others in this area."))

		enterer.area = src

		return TRUE

	return FALSE

/area/Exited(var/atom/movable/exiter,var/atom/old_loc)
	return TRUE

/area/proc/set_dynamic_lighting(var/new_dynamic_lighting = TRUE)
	if (new_dynamic_lighting == dynamic_lighting)
		return FALSE

	dynamic_lighting = new_dynamic_lighting

	if (new_dynamic_lighting)
		for (var/turf/T in world)
			if (T.dynamic_lighting)
				T.lighting_build_overlay()

	else
		for (var/turf/T in world)
			if (T.lighting_overlay)
				T.lighting_clear_overlay()

	return TRUE
