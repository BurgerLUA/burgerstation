/area/
	name = "AREA ERROR"
	icon = 'icons/area/area.dmi'
	icon_state = ""
	layer = LAYER_AREA
	plane = PLANE_AREA
	invisibility = 101

	mouse_opacity = 0

	var/flags_area = FLAG_AREA_NONE

	var/sound_environment = ENVIRONMENT_NONE

	var/area_identifier //The identifier of the area. Useful for simulating seperate levels on the same level, without pinpointer issues. Also used by telecomms.
	var/trackable = FALSE //Trackable area by the game.

	var/map_color_r = rgb(255,0,0,255)
	var/map_color_g = rgb(0,255,0,255)
	var/map_color_b = rgb(0,0,255,255)
	var/map_color_a = rgb(0,0,0,255)

	var/ambient_sound
	var/list/random_sounds = list()
	var/list/tracks = list()

	var/level_multiplier = 1 //Adjust the level multiplier for mobs that spawn here using spawners. This actually just multiplies their experience from the template.

	var/hazard //The id of the hazard

	var/sunlight_freq = 0
	var/sunlight_color = "#FFFFFF"

	//var/assoc_wishgranter //The wishgranter ID this is area is associated with, if any.

	var/weather = WEATHER_NONE //Optional weather

	var/ambient_temperature = T0C + 20

	var/cheese_type = /reagent/nutrition/cheese/

	var/turf/destruction_turf //The destruction turf of the area, if any.

	var/list/turf/sunlight_turfs = list()

	var/defend = FALSE //Set to true if you're supposed to defend this area.

	var/safe_storage = FALSE

	var/interior = FALSE

	var/average_x = 0
	var/average_y = 0

	var/allow_ghosts = TRUE //Set to false to prevent a ghost from teleporting to this location.


/area/proc/is_space()
	return FALSE

/area/Destroy()

	if(sunlight_turfs)
		sunlight_turfs.Cut()

	SSarea.all_areas -= src.type
	SSarea.areas_by_identifier[area_identifier] -= src

	return ..()

/area/proc/update_lighting_overlay_color(var/desired_color)

	for(var/turf/T in contents)
		if(T.lighting_overlay)
			T.lighting_overlay.color = desired_color

	return TRUE

/area/Initialize()

	if(weather)
		icon = 'icons/area/weather.dmi'
		icon_state = weather

	var/area_count = 0
	average_x = 0
	average_y = 0

	for(var/turf/T in contents)
		average_x += T.x
		average_y += T.y
		area_count += 1

	if(!area_count)
		log_error("Warning: [src.get_debug_name()] had no turf contents.")
		average_x = 1
		average_y = 1
	else
		average_x = CEILING(average_x/area_count,1)
		average_y = CEILING(average_y/area_count,1)

	return ..()

/area/proc/setup_sunlight(var/turf/T)

	if(sunlight_freq == 0)
		return FALSE

	if(T.desired_light_power && T.desired_light_range)
		return FALSE //Already has a light.

	if(T.setup_turf_light(sunlight_freq))
		return TRUE

	if((T.x % sunlight_freq) || (T.y % sunlight_freq))
		return FALSE

	T.desired_light_power = 1
	T.desired_light_range = sunlight_freq
	T.desired_light_color = sunlight_color
	T.update_atom_light()

	return TRUE

/area/Entered(var/atom/movable/enterer,var/atom/old_loc)

	if(is_player(enterer))

		var/mob/living/advanced/player/P = enterer
		if(flags_area & FLAGS_AREA_SINGLEPLAYER)
			P.see_invisible = INVISIBILITY_NO_PLAYERS

	if(ENABLE_TRACKS && ismob(enterer) && !istype(enterer,/mob/abstract/observer/menu))
		var/mob/M = enterer
		if(M.client && length(tracks) && (!M.client.next_music_track || M.client.next_music_track <= world.time))
			play_music_track(pick(tracks),M.client)

	if(enterer.area != src)
		if(ismob(enterer) && !istype(enterer,/mob/abstract/observer/menu))
			var/mob/M = enterer
			if(M.client)
				if(!ambient_sound)
					stop_ambient_sounds(M)
				else if(!enterer.area || enterer.area.ambient_sound != ambient_sound)
					play_ambient_sound(ambient_sound,list(M),environment = sound_environment,loop = TRUE)

		enterer.area = src

		return TRUE

	return FALSE

/area/Exited(var/atom/movable/exiter,var/atom/old_loc)

	if(is_player(exiter))
		var/mob/living/advanced/player/P = exiter
		if(flags_area & FLAGS_AREA_SINGLEPLAYER)
			P.see_invisible = initial(P.see_invisible)

	return TRUE


/area/proc/smash_all_lights()
	for(var/obj/structure/interactive/lighting/T in src.contents)
		CHECK_TICK(75,FPS_SERVER)
		if(!T.desired_light_color)
			continue
		T.on_destruction(null,TRUE)
	return TRUE

/area/proc/toggle_all_lights()
	var/obj/structure/interactive/light_switch/LS = locate() in src.contents
	if(LS && LS.on)
		LS.toggle()
		return TRUE
	return FALSE
