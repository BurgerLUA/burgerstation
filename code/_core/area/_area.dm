/area/
	name = "ERROR AREA"
	icon = 'icons/area/area.dmi'
	icon_state = ""
	layer = LAYER_AREA
	plane = PLANE_AREA //This should never be changed. Just use interior=TRUE
	alpha = 150

	mouse_opacity = 0

	var/flags_area = FLAG_AREA_NONE

	var/sound_environment = ENVIRONMENT_NONE

	var/area_identifier = "Fallback" //The identifier of the area. Useful for simulating seperate levels on the same level, without pinpointer issues. Also used by telecomms.
	var/trackable = FALSE //Trackable area by the game.

	var/map_color //The area's map color. Leave blank to refer to the turf instead.
	var/map_color_ignore_dense = FALSE

	var/ambient_sound
	var/list/random_sounds = list()
	var/list/tracks = list()

	var/weather = WEATHER_NONE
	var/hazard //The id of the hazard

	var/sunlight_freq = 0
	var/sunlight_color = "#FFFFFF"

	var/ambient_temperature = T0C + 20

	var/cheese_type = /reagent/nutrition/cheese/

	var/turf/destruction_turf //The destruction turf of the area, if any.

	var/safe_storage = FALSE //Set to true if items don't ever delete due to chunk cleaning. This means mobs don't get spawned as well.
	var/interior = FALSE

	var/average_x = 0
	var/average_y = 0

	var/allow_ghost = FALSE //Allow ghosts to use this area if one spawns in it.

	var/flags_generation = FLAG_GENERATION_NONE

	//Power Code
	var/default_state_power_lights = OFF
	var/default_state_power_machines = OFF
	var/default_state_power_doors = OFF


	var/no_apc = FALSE //Used for error checking.
	var/requires_power = FALSE //Set to true if everything is this area requires power.
	var/obj/structure/interactive/power/apc/linked_apc //The area's APC, if any. Can be an APC from another area.
	var/link_to_parent_apc = FALSE //Set to true if APCs for this area can be linked to its parent. Only used on map load.

	var/power_draw = 0

	var/enable_power_doors = OFF
	var/enable_power_machines = OFF
	var/enable_power_lights = OFF

	var/list/obj/structure/interactive/door/powered_doors
	var/list/obj/structure/interactive/powered_machines
	var/list/obj/structure/interactive/lighting/powered_lights

	var/list/obj/structure/interactive/light_switch/light_switches

	var/list/obj/particle_managers = list()

	var/horde_data/horde_data

	var/allow_area_expansion = FALSE //Allow this area to be automatically expanded in area generation.

	var/allow_climbing = FALSE

	var/turf/dynamic_rock_gen_turf = /turf/simulated/wall/rock

/area/proc/is_space()
	return FALSE

/area/PreDestroy()
	. = ..()
	SSarea.all_areas -= src.type
	SSarea.areas_by_identifier[area_identifier] -= src

/area/Destroy()

	powered_doors.Cut()
	powered_machines.Cut()
	powered_lights.Cut()

	return ..()

/area/proc/update_lighting_overlay_color(var/desired_color)

	for(var/turf/T in contents)
		if(T.lighting_overlay)
			T.lighting_overlay.color = desired_color

	return TRUE

/area/New(var/desired_loc)

	if(requires_power)
		powered_doors = list()
		powered_machines = list()
		powered_lights = list()
		light_switches = list()

	if(interior || src.weather)
		plane = PLANE_AREA_INTERIOR
	else
		plane = PLANE_AREA_EXTERIOR

	if(sunlight_freq > 1) //Odd sunlight freqs greater than 1 must be even.
		sunlight_freq = CEILING(sunlight_freq,2)

	if(SSarea) SSarea.all_areas[src.type] = src
	//Reason for above: The literal /area/ type will try to initialize here basically.

/area/Initialize()

	if(src.area_identifier)
		if(!SSarea.areas_by_identifier[src.area_identifier])
			SSarea.areas_by_identifier[src.area_identifier] = list()
		SSarea.areas_by_identifier[src.area_identifier] += src

	. = ..()

	if(plane == PLANE_AREA_EXTERIOR)
		icon = 'icons/area/area.dmi'
		icon_state = "black"
		invisibility = 0
	else
		invisibility = 101

	alpha = 255

	if(length(src.random_sounds))
		SSarea.areas_ambient += src

	if(src.weather && CONFIG("ENABLE_WEATHER",FALSE))
		src.invisibility = 0
		src.alpha = 0
		switch(src.weather)
			if(WEATHER_SNOW)
				SSarea.areas_snow += src
			if(WEATHER_RAIN)
				SSarea.areas_rain += src
			if(WEATHER_SANDSTORM)
				SSarea.areas_sandstorm += src
			if(WEATHER_VOLCANIC)
				SSarea.areas_volcanic += src

/area/Finalize()
	. = ..()
	generate_average()

/area/proc/generate_average()

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

	return TRUE

/area/proc/setup_sunlight(var/turf/T)

	if(sunlight_freq <= 0)
		return FALSE

	if(T.setup_turf_light(sunlight_freq))
		return TRUE

	if(sunlight_freq > 1)
		if(T.x % sunlight_freq)
			return FALSE
		var/bonus = !(T.x % (sunlight_freq*2)) && sunlight_freq > 1 ? sunlight_freq*0.5 : 0
		if((T.y+bonus) % sunlight_freq)
			return FALSE

	T.desired_light_power = 1
	T.desired_light_range = 1 + sunlight_freq
	T.desired_light_color = sunlight_color
	T.update_atom_light()

	return TRUE

/area/Entered(var/atom/movable/enterer,var/atom/old_loc)
	return TRUE

/area/Exited(var/atom/movable/exiter,var/atom/old_loc)
	return TRUE

/area/proc/smash_all_lights()
	for(var/obj/structure/interactive/lighting/T in src.contents)
		CHECK_TICK(75,FPS_SERVER)
		if(!T.desired_light_color)
			continue
		T.on_destruction()
	return TRUE

/area/proc/apc_process()

	//Priority:
	//Doors
	//Machines
	//Lights

	if(!linked_apc || !linked_apc.cell)
		toggle_power_doors(OFF|AUTO)
		toggle_power_machines(OFF|AUTO)
		toggle_power_lights(OFF|AUTO)
		return FALSE

	//Getting power.
	var/available_charge = 0
	var/max_charge = 1
	if(linked_apc && linked_apc.cell)
		available_charge = linked_apc.cell.charge_current
		max_charge = linked_apc.cell.charge_max

	//Doors
	if(enable_power_doors & AUTO)
		if(available_charge/max_charge >= 0.1)
			if(!(enable_power_doors & ON)) toggle_power_doors(ON|AUTO)
		else if(!(enable_power_doors & OFF))
			toggle_power_doors(OFF|AUTO)
	else if(available_charge <= 0 && !(enable_power_doors & OFF))
		toggle_power_doors(OFF|AUTO)

	//Machines
	if(enable_power_machines & AUTO)
		if(available_charge/max_charge >= 0.2)
			if(!(enable_power_machines & ON)) toggle_power_machines(ON|AUTO)
		else if(!(enable_power_machines & OFF))
			toggle_power_machines(OFF|AUTO)
	else if(available_charge <= 0 && !(enable_power_machines & OFF))
		toggle_power_machines(OFF|AUTO)

	//Lights
	if(enable_power_lights & AUTO)
		if(available_charge/max_charge >= 0.3)
			if(!(enable_power_lights & ON)) toggle_power_lights(ON|AUTO)
		else if(!(enable_power_lights & OFF))
			toggle_power_lights(OFF|AUTO)
	else if(available_charge <= 0 && !(enable_power_lights & OFF))
		toggle_power_lights(OFF|AUTO)

	//Removing power.
	linked_apc.cell.charge_current = max(0,linked_apc.cell.charge_current - power_draw)

	return TRUE


/area/proc/toggle_power_doors(var/enable=ON|AUTO,var/force=FALSE)

	if(!requires_power)
		CRASH("Called toggle_power_doors on an [src.type] that doesn't require power.")

	if((enable & ON) && (enable & OFF))
		enable &= ~OFF

	enable_power_doors = enable

	for(var/k in powered_doors)
		var/obj/structure/interactive/D = k
		if(!D.apc_powered)
			continue
		if(D.power_type != POWER_DOOR)
			continue
		if(D.powered == (enable_power_doors & ON ? TRUE : FALSE) && !force)
			continue
		D.powered = enable_power_doors & ON ? TRUE : FALSE
		if(D.powered)
			D.update_power_draw(D.get_power_draw())
		else
			D.update_power_draw(0)

	return TRUE


/area/proc/toggle_power_machines(var/enable=ON|AUTO,var/force=FALSE)

	if(!requires_power)
		CRASH("Called toggle_power_machines on an [src.type] that doesn't require power.")

	if((enable & ON) && (enable & OFF))
		enable &= ~OFF

	enable_power_machines = enable

	for(var/k in powered_machines)
		var/obj/structure/interactive/P = k
		if(!P.apc_powered)
			continue
		if(P.power_type != POWER_MACHINE)
			continue
		if(P.powered == (enable_power_machines & ON ? TRUE : FALSE) && !force)
			continue
		P.powered = enable_power_machines & ON ? TRUE : FALSE
		if(P.powered)
			P.update_power_draw(P.get_power_draw())
		else
			P.update_power_draw(0)

	return TRUE

/area/proc/toggle_power_lights(var/enable=ON|AUTO,var/force=FALSE)

	if(!requires_power)
		CRASH("Called toggle_power_lights on an [src.type] that doesn't require power.")

	if((enable & ON) && (enable & OFF))
		enable &= ~OFF

	enable_power_lights = enable

	for(var/k in powered_lights)
		var/obj/structure/interactive/L = k
		if(!L.apc_powered)
			continue
		if(L.power_type != POWER_LIGHT)
			continue
		if(L.powered == (enable_power_lights & ON ? TRUE : FALSE) && !force)
			continue
		L.powered = enable_power_lights & ON ? TRUE : FALSE
		if(L.powered)
			L.update_power_draw(L.get_power_draw())
		else
			L.update_power_draw(0)

	for(var/k in light_switches)
		var/obj/structure/interactive/light_switch/LS = k
		if(LS.on == (enable_power_lights & ON ? TRUE : FALSE) && !force)
			continue
		LS.on = enable_power_lights & ON ? TRUE : FALSE
		LS.update_atom_light()
		LS.update_icon()

	return TRUE