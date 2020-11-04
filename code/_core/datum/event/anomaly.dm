/event/anomaly
	name = "Meme Anomaly"

	probability = 20 //relative

	var/list/valid_areas = list()

	var/list/possible_anomalies = list(
		/mob/living/simple/npc/dick_kickem = 3.5,
		/mob/living/simple/npc/glockroach = 7,
		/mob/living/simple/npc/bullshark = 3.5,
		/mob/living/simple/npc/clown/blob = 1,
		/mob/living/simple/npc/clown/hulk = 1,
		/mob/living/simple/npc/clown/long = 1,
		/mob/living/simple/npc/clown/lube = 1,
		/mob/living/simple/npc/clown/mutant = 1,
		/mob/living/simple/npc/clown/pie = 1,
		/mob/living/simple/npc/clown/tree =1,
		/mob/living/simple/npc/bot/medibot/rogue = 7,
		/mob/living/simple/npc/antag = 3.5
	)

	occurances_max = 5

/event/anomaly/New()

	for(var/area/A in world)
		if(A.z != Z_LEVEL_STATION)
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