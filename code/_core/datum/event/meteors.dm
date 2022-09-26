/event/meteors
	name = "Meteor Shower"

	probability = 10 //relative
	duration = SECONDS_TO_DECISECONDS(60)

	occurances_max = 5

/event/meteors/on_start()

	if(!length(all_players))
		return FALSE

	log_debug("Starting Meteor Event")

	announce(
		"Central Command Meteorology Division",
		"Meteor Storm Inbound",
		"Meteors have been detected near the area of operations.",
		sound_to_play = 'sound/voice/announcement/meteors.ogg'
	)

	return ..()

/event/meteors/on_life()

	if(!length(all_players))
		return FALSE

	if(lifetime >= SECONDS_TO_DECISECONDS(10))
		for(var/i=1,i<=5,i++)
			var/mob/living/advanced/player/P = pick(all_players)
			if(P.dead || !P.ckey)
				continue
			var/list/valid_turfs = list()
			for(var/turf/simulated/floor/F in range(VIEW_RANGE*0.75,P))
				var/area/A = F.loc
				if(A.interior)
					continue
				if(A.flags_area & FLAG_AREA_NO_EVENTS)
					continue
				valid_turfs += F
			if(!length(valid_turfs))
				continue
			var/turf/T = pick(valid_turfs)
			new /obj/effect/falling_meteor(T)
			CHECK_TICK_SAFE(50,FPS_SERVER*10)

	. = ..()

/event/meteors/on_end()
	log_debug("Ending Meteor Event")
	return ..()