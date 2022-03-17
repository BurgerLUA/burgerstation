/area/
	name = "Unknown Area"
	icon = 'icons/area/area.dmi'
	icon_state = ""
	layer = LAYER_AREA
	plane = PLANE_AREA //This should never be changed. Just use interior=TRUE
	invisibility = 101
	alpha = 150

	mouse_opacity = 0

	var/flags_area = FLAG_AREA_NONE

	var/sound_environment = ENVIRONMENT_NONE

	var/area_identifier = "Fallback" //The identifier of the area. Useful for simulating seperate levels on the same level, without pinpointer issues. Also used by telecomms.
	var/trackable = FALSE //Trackable area by the game.

	var/map_color //The area's map color. Leave blank to refer to the turf instead.

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

	var/list/turf/sunlight_turfs = list()

	var/safe_storage = FALSE //Set to true if items don't ever delete due to chunk cleaning. This means mobs don't get spawned as well.
	var/interior = FALSE

	var/average_x = 0
	var/average_y = 0

	var/allow_ghost = FALSE //Allow ghosts to use this area if one spawns in it.

	var/flags_generation = FLAG_GENERATION_NONE

	var/obj/structure/interactive/powered/apc/apc //The area's APC, if any.

	//Power Code
	var/requires_power = FALSE //Set to true if everything is this area requires power.

	var/power_draw = 0

	var/enable_power_doors = FALSE
	var/enable_power_machines = FALSE
	var/enable_power_lights = FALSE

	var/list/obj/structure/interactive/door/powered_doors
	var/list/obj/structure/interactive/powered/powered_machines
	var/list/obj/structure/interactive/lighting/powered_lights

	var/list/obj/structure/interactive/light_switch/light_switches

/area/proc/is_space()
	return FALSE

/area/Destroy()

	if(sunlight_turfs)
		sunlight_turfs.Cut()

	SSarea.all_areas -= src.type
	SSarea.areas_by_identifier[area_identifier] -= src

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

	if(interior)
		plane = PLANE_AREA_INTERIOR
	else
		plane = PLANE_AREA_EXTERIOR

/area/Initialize()

	if(plane == PLANE_AREA_EXTERIOR)
		icon = 'icons/area/area.dmi'
		icon_state = "black"
		invisibility = 0
	else
		invisibility = 101

	alpha = 255

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

/area/proc/apc_process()

	//Priority:
	//Doors
	//Machines
	//Lights

	//Getting Power
	var/available_charge = 0
	var/max_charge = 1
	if(apc && apc.cell)
		available_charge = apc.cell.charge_current
		max_charge = apc.cell.charge_max

	//Doors
	toggle_power_doors(available_charge > 0)

	//Machines
	toggle_power_machines(available_charge/max_charge >= 0.2)

	//Lights
	if(available_charge/max_charge <= 0.3)
		toggle_power_lights(FALSE) //Lights have to be manually enabled again.

	//Removing power.
	if(apc && apc.cell)
		apc.cell.charge_current = max(0,apc.cell.charge_current - power_draw)

	return TRUE


/area/proc/toggle_power_doors(var/enable=TRUE,var/force=FALSE)

	if(!requires_power)
		CRASH("Called toggle_power_doors on an [src.type] that doesn't require power.")

	if(enable == enable_power_doors && !force)
		return FALSE

	enable_power_doors = enable

	for(var/k in powered_doors)
		var/obj/structure/interactive/door/D = k
		if(!D.uses_power)
			continue
		D.powered = enable_power_doors
		if(D.powered)
			D.update_power_draw(D.get_power_draw())
		else
			D.update_power_draw(0)
		D.update_sprite()

	return TRUE


/area/proc/toggle_power_machines(var/enable=TRUE,var/force=FALSE)

	if(!requires_power)
		CRASH("Called toggle_power_machines on an [src.type] that doesn't require power.")

	if(enable == enable_power_machines && !force)
		return FALSE

	enable_power_machines = enable

	for(var/k in powered_machines)
		var/obj/structure/interactive/powered/P = k
		if(P.wire_powered)
			continue
		P.powered = enable_power_machines
		if(P.powered)
			P.update_power_draw(P.get_power_draw())
		else
			P.update_power_draw(0)
		P.update_sprite()

	return TRUE

/area/proc/toggle_power_lights(var/enable=TRUE,var/lightswitch=FALSE,var/force=FALSE)

	if(!requires_power)
		CRASH("Called toggle_power_lights on an [src.type] that doesn't require power.")

	if(enable == enable_power_lights && !force)
		return FALSE

	enable_power_lights = enable

	for(var/k in powered_lights)
		var/obj/structure/interactive/lighting/L = k
		if(!L.lightswitch && lightswitch)
			continue
		if(L.on == enable_power_lights)
			continue
		L.on = enable_power_lights
		if(L.on)
			L.update_power_draw(L.get_power_draw())
		else
			L.update_power_draw(0)
		L.update_atom_light()
		L.update_sprite()

	if(lightswitch)
		for(var/k in light_switches)
			var/obj/structure/interactive/light_switch/LS = k
			if(LS.on == enable_power_lights)
				continue
			LS.on = enable_power_lights
			LS.update_sprite()

	return TRUE