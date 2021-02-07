/event/anomaly
	name = "Meme Anomaly"

	probability = 20 //relative

	var/list/valid_areas = list()

	var/list/possible_anomalies = list(
		/mob/living/simple/dick_kickem = 1,
		/mob/living/simple/glockroach = 6,
		/mob/living/simple/bullshark = 4,
		/mob/living/simple/bot/medibot/rogue = 6,
		/mob/living/simple/screech = 4
	)

	occurances_max = 5

/event/anomaly/New()

	for(var/area/A in world)
		if(A.area_identifier != "Burgerstation")
			continue
		if(A.flags_area & FLAGS_AREA_NO_EVENTS)
			continue
		valid_areas += A

	log_debug("Found [length(valid_areas)] valid areas for anomaly event.")

	return ..()

/event/anomaly/on_start()

	log_debug("Starting Anomaly Event")

	var/area/chosen_area = pick(valid_areas)
	var/list/valid_turfs = list()
	for(var/turf/simulated/floor/T in chosen_area.contents)
		if(T.is_occupied()) continue
		valid_turfs += T

	if(!length(valid_turfs))
		return FALSE

	announce(
		"Central Command Anomaly Division",
		"Anomaly Detected",
		"A strange anomaly reading was detected in the area of operations. Predicted area: [chosen_area.name].",
		sound_to_play = 'sound/voice/announcement/anomaly.ogg'
	)


	var/turf/T = pick(valid_turfs)
	CREATE(/obj/effect/temp/wormhole,T)
	var/spawn_type = pick(possible_anomalies)
	var/amount_to_spawn = possible_anomalies[spawn_type]
	for(var/i=1,i<=amount_to_spawn,i++)
		var/atom/movable/M = new spawn_type(T)
		INITIALIZE(M)
		GENERATE(M)
		FINALIZE(M)

	notify_ghosts("An anomaly is being created!",T)

	return ..()