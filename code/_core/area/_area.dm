/area/
	name = "Unknown Area"
	icon = 'icons/area/area.dmi'
	icon_state = ""
	layer = LAYER_AREA
	plane = PLANE_AREA
	invisibility = 101

	mouse_opacity = 0

	var/flags_area = FLAG_AREA_NONE

	var/sound_environment = ENVIRONMENT_NONE

	var/area_identifier = "Fallback" //The identifier of the area. Useful for simulating seperate levels on the same level, without pinpointer issues. Also used by telecomms.
	var/trackable = FALSE //Trackable area by the game.

	var/map_color //The area's map color. Leave blank to refer to the turf instead.

	var/ambient_sound
	var/list/random_sounds = list()
	var/list/tracks = list()

	var/hazard //The id of the hazard

	var/sunlight_freq = 0
	var/sunlight_color = "#FFFFFF"

	var/weather = WEATHER_NONE //Optional weather

	var/ambient_temperature = T0C + 20

	var/cheese_type = /reagent/nutrition/cheese/

	var/turf/destruction_turf //The destruction turf of the area, if any.

	var/list/turf/sunlight_turfs = list()

	var/safe_storage = FALSE //Set to true if items don't ever delete due to chunk cleaning. This means mobs don't get spawned as well.
	var/interior = FALSE

	var/average_x = 0
	var/average_y = 0

	var/allow_ghost = FALSE //Allow ghosts to use this area if one spawns in it.

	var/flags_generation = FLAG_GENERATION_NONE


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
	return FALSE

/area/Exited(var/atom/movable/exiter,var/atom/old_loc)
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

/area/proc/sync_lights(var/desired_state = TRUE)

	for(var/obj/structure/interactive/lighting/L in src.contents)
		if(!L.lightswitch)
			continue
		if(L.on == desired_state)
			continue
		L.on = desired_state
		L.update_atom_light()
		L.update_sprite()

	for(var/obj/structure/interactive/light_switch/LS in src.contents)
		if(LS.on == desired_state)
			continue
		LS.on = desired_state
		LS.update_sprite()

	return TRUE