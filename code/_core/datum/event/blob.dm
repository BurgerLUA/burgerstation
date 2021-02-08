/event/blob
	name = "Blob Biohazard"

	probability = 5 //relative

	var/list/turf/valid_turfs = list()
	var/list/area/valid_areas = list()

	occurances_max = 1

/event/blob/Destroy()
	valid_turfs.Cut()
	valid_areas.Cut()
	return ..()

/event/blob/New()

	for(var/area/A in world)
		if(A.area_identifier != "Mission")
			continue
		if(A.interior)
			continue
		if(A.flags_area & FLAGS_AREA_NO_EVENTS)
			continue
		valid_areas += A

	log_debug("Found [length(valid_turfs)] valid turfs for blob event.")

	return ..()

/event/blob/on_start()

	valid_turfs.Cut()

	log_debug("Starting Blob Event")

	var/area/A

	var/chances = 20

	if(length(valid_areas))
		while(TRUE && chances > 0)
			CHECK_TICK(50,FPS_SERVER*10)
			A = pick(valid_areas)
			var/mob/living/advanced/player/P = locate() in A.contents
			if(!P) break
			chances--
		for(var/turf/simulated/floor/T in A.contents)
			if(T.x <= 10 || T.x >= WORLD_SIZE - 10)
				continue
			if(T.y <= 10 || T.y >= WORLD_SIZE - 10)
				continue
			valid_turfs += T

	if(!length(valid_turfs))
		return FALSE

	announce(
		"Central Command Xenoviral Division",
		"Blob Alert",
		"A level 5 \"blob\" biohazard growth has been detected near the area of operations. Predicted area: [A.name].",
		sound_to_play = 'sound/voice/announcement/blob.ogg'
	)

	var/turf/T = pick(valid_turfs)

	CREATE(/obj/structure/interactive/blob/core,T)

	notify_ghosts("A blob is being created!",T)

	return ..()

/event/blob/on_end()
	log_debug("Ending Blob Event")
	return ..()