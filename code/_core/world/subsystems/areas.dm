SUBSYSTEM_DEF(area)
	name = "Area Subsystem"
	desc = "Manages the icon states of areas, aka weather and climate."
	priority = SS_ORDER_AREAS
	tick_rate = SECONDS_TO_TICKS(300)

	var/list/area/areas_rain = list()
	var/list/area/areas_snow = list()
	var/list/area/areas_sandstorm = list()
	var/list/area/areas_volcanic = list()
	var/list/area/areas_ambient = list()

	var/is_raining = TRUE
	var/is_snowing = TRUE
	var/is_sandstorming = TRUE
	var/is_volcanic = TRUE

	var/list/all_areas = list()

	var/list/areas_by_identifier = list()

/subsystem/area/unclog(var/mob/caller)
	src.tick_rate = 0
	log_subsystem(src.name,"Shutting down.")
	. = ..()

/subsystem/area/Initialize()

	var/area/null_area

	log_subsystem(name,"Initializing areas...")

	for(var/k in all_areas)
		var/area/A = all_areas[k]
		INITIALIZE(A)
		if(A.type == /area/)
			null_area = A
		CHECK_TICK_HARD

	log_subsystem(name,"Generating areas...")

	for(var/k in all_areas)
		var/area/A = all_areas[k]
		GENERATE(A)
		CHECK_TICK_HARD

	log_subsystem(name,"Finalizing areas...")

	var/area_count = 0
	for(var/k in all_areas)
		var/area/A = all_areas[k]
		FINALIZE(A)
		area_count++
		CHECK_TICK_HARD

	log_subsystem(name,"Finalized [area_count] total areas.")

	var/changed_areas = 0

	//First (strict) pass.
	while(TRUE)
		var/found_turf = FALSE
		for(var/turf/simulated/T in null_area.contents) //This checks simulated turfs only.
			for(var/d in DIRECTIONS_CARDINAL)
				var/turf/nt = get_step(T,d)
				if(!nt)
					new/area/mission/out_of_bounds(T)
					changed_areas++
					found_turf = TRUE
					break
				var/area/A = nt.loc
				if(A.allow_area_expansion)
					new A.type(T)
					changed_areas++
					found_turf = TRUE
					break
			CHECK_TICK_HARD
		if(!found_turf)
			break

	//Second pass.
	while(TRUE)
		var/found_turf = FALSE
		for(var/turf/simulated/T in null_area.contents) //This checks simulated turfs only.
			for(var/d in DIRECTIONS_CARDINAL)
				var/turf/nt = get_step(T,d)
				if(!nt)
					new/area/mission/out_of_bounds(T)
					changed_areas++
					found_turf = TRUE
					break
				var/area/A = nt.loc
				if(A.type != /area/)
					new A.type(T)
					changed_areas++
					found_turf = TRUE
					break
			CHECK_TICK_HARD
		if(!found_turf)
			break

	log_subsystem(src.name,"Changed [changed_areas] turfs with bad areas into good areas.")

	var/bad_count = 0
	for(var/turf/simulated/T in null_area.contents)
		bad_count++

	if(length(bad_count) > 0)
		log_subsystem(src.name,"WARNING: Failed to change [bad_count] turfs with bad areas into good areas.")

	sort_tim(all_areas,/proc/cmp_path_asc,associative=TRUE)

	if(CONFIG("ENABLE_WEATHER",FALSE))
		set_weather(WEATHER_RAIN,is_raining,areas_rain)
		set_weather(WEATHER_SNOW,is_snowing,areas_snow)
		set_weather(WEATHER_SANDSTORM,is_sandstorming,areas_sandstorm)
		set_weather(WEATHER_VOLCANIC,is_volcanic,areas_volcanic)

	. = ..()

/subsystem/area/on_life()

	if(prob(is_raining ? WEATHER_REMOVE_CHANCE : WEATHER_ADD_CHANCE))
		is_raining = !is_raining
		set_weather(WEATHER_RAIN,is_raining,areas_rain)

	if(prob(is_snowing ? WEATHER_REMOVE_CHANCE : WEATHER_ADD_CHANCE))
		is_snowing = !is_snowing
		set_weather(WEATHER_SNOW,is_snowing,areas_snow)

	if(prob(is_sandstorming ? WEATHER_REMOVE_CHANCE : WEATHER_ADD_CHANCE))
		is_sandstorming = !is_sandstorming
		set_weather(WEATHER_SANDSTORM,is_sandstorming,areas_sandstorm)

	if(prob(is_volcanic ? WEATHER_REMOVE_CHANCE : WEATHER_ADD_CHANCE))
		is_volcanic = !is_volcanic
		set_weather(WEATHER_VOLCANIC,is_volcanic,areas_volcanic)

	for(var/k in areas_ambient)
		var/area/A = k
		if(!A)
			areas_ambient -= k
			continue
		CHECK_TICK(tick_usage_max,0)
		var/sound_to_play = pick(A.random_sounds)
		var/list/valid_players = list()
		for(var/mob/living/advanced/player/P in A.contents)
			if(!P.client || P.dead)
				continue
			valid_players += P
		if(!length(valid_players))
			continue
		play_random_ambient_sound(sound_to_play,valid_players)

	return TRUE

/subsystem/area/proc/set_weather(var/weather_type,var/enabled=FALSE,var/list/area/affected_areas)
	for(var/k in affected_areas)
		var/area/A = k
		if(!A)
			affected_areas -= k
			continue
		CHECK_TICK(tick_usage_max,0)
		if(enabled)
			A.icon = 'icons/area/weather.dmi'
			A.icon_state = weather_type
			A.color = "#000000"
			switch(weather_type)
				if(WEATHER_RAIN)
					animate(A,alpha=100,color="#429FCE",time=SECONDS_TO_DECISECONDS(10))
				if(WEATHER_SNOW)
					animate(A,alpha=255,color="#FFFFFF",time=SECONDS_TO_DECISECONDS(10))
				if(WEATHER_SANDSTORM)
					animate(A,alpha=255,color="#E5CDA7",time=SECONDS_TO_DECISECONDS(5))
				if(WEATHER_VOLCANIC)
					animate(A,alpha=105, color="#C2C2C2",time=SECONDS_TO_DECISECONDS(10))

		else
			animate(A,alpha=0,time=SECONDS_TO_DECISECONDS(10))
