/event/anomaly
	name = "Meme Anomaly"

	probability = 20 //relative

	var/list/possible_anomalies = list(
		/mob/living/simple/dick_kickem = 1,
		/mob/living/simple/glockroach = 6,
		/mob/living/simple/bullshark = 4,
		/mob/living/simple/bot/medibot/rogue = 6,
		/mob/living/simple/screech = 4
	)

	occurances_max = 5

/event/anomaly/on_start()

	log_debug("Starting Anomaly Event")

	var/turf/T = find_safe_turf_for_event(attempts=10)

	if(!T)
		return FALSE

	announce(
		"Central Command Anomaly Division",
		"Anomaly Detected",
		"A strange anomaly reading was detected in the area of operation. Predicted location: [T.x],[T.y].",
		sound_to_play = 'sound/voice/announcement/anomaly.ogg'
	)

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