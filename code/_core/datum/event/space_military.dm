/event/space_military
	name = "Space Military Invasion"

	probability = 0 //Doesn't occur naturally

	var/list/turf/valid_turfs = list()
	var/list/area/valid_areas = list()

	var/list/enemy_types = list(
		/mob/living/advanced/npc/space_soldier
	)

	occurances_max = 1

/event/space_military/Destroy()
	valid_turfs.Cut()
	valid_areas.Cut()
	return ..()

/event/space_military/New()

	for(var/area/A in world)
		if(A.area_identifier != "Mission")
			continue
		if(A.interior)
			continue
		if(A.flags_area & FLAGS_AREA_NO_EVENTS)
			continue
		valid_areas += A

	log_debug("Found [length(valid_areas)] valid areas for space military event.")

	return ..()

/event/space_military/on_start()

	valid_turfs.Cut()

	log_debug("Starting Space Military Invasion Event")

	var/list/announce_areas = list()

	for(var/i=1,i<=4,i++)
		if(!length(valid_areas))
			return FALSE
		var/area/A = pick(valid_areas)
		announce_areas |= A.name
		for(var/turf/simulated/floor/T in A.contents)
			valid_turfs += T

	if(!length(valid_turfs))
		return FALSE

	announce(
		"Space Military",
		"Declaration of War",
		"Hey uuuuuuuuuuuuuuuuuuh it appears that there is oil and war crimes in the area so uh... we're invading now and establishing democracy and freedom. Stay away from [english_list(announce_areas)] if you don't want to get shot.",
		//sound_to_play = 'sound/voice/announcement/migration.ogg'
	)

	for(var/i=1,i<=30,i++)
		CHECK_TICK(50,FPS_SERVER*10)
		if(!length(valid_turfs))
			break
		var/turf/T = pick(valid_turfs)
		if(!T)
			break
		var/chosen_enemy = pickweight(enemy_types)
		CREATE_SAFE(chosen_enemy,T)

	return ..()

/event/space_military/on_end()
	log_debug("Ending Space Military Event")
	return ..()