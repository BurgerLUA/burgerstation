/event/anomaly
	name = "Meme Anomaly"

	probability = 10 //relative

	var/list/valid_areas = list()

	var/list/possible_anomalies = list(
		/mob/living/simple/npc/dick_kickem = 1,
		/mob/living/simple/npc/glockroach = 5,
		/mob/living/simple/npc/bullshark = 3,
		/mob/living/simple/npc/clown/blob = 2,
		/mob/living/simple/npc/clown/hulk = 1,
		/mob/living/simple/npc/clown/long = 3,
		/mob/living/simple/npc/clown/lube = 4,
		/mob/living/simple/npc/clown/mutant = 2,
		/mob/living/simple/npc/clown/pie = 3,
		/mob/living/simple/npc/clown/tree = 4,
		/mob/living/simple/npc/bot/medibot/rogue = 5
	)

	occurances_max = 5

/event/anomaly/New()

	for(var/area/A in world)
		if(A.z < Z_LEVEL_MISSION)
			continue
		if(A.interior)
			continue
		if(A.flags_area & FLAGS_AREA_NO_EVENTS)
			continue
		valid_areas += A

	LOG_DEBUG("Found [length(valid_areas)] valid areas for anomaly event.")

	return ..()

/event/anomaly/on_start()

	LOG_DEBUG("Starting Anomaly Event")

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