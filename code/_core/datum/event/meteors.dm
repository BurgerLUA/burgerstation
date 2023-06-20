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

	var/list/player_blacklist = list()

	if(lifetime >= SECONDS_TO_DECISECONDS(10))
		for(var/i=1,i<=5,i++) //Limit 5 per.
			if(!length(all_players))
				break
			var/mob/living/advanced/player/P = pick(all_players)
			if(player_blacklist[P])
				continue
			player_blacklist[P] = TRUE
			if(P.dead || !P.ckey)
				continue
			var/turf/T = get_turf(P)
			if(!T)
				continue
			var/area/A = T.loc
			if(A.area_identifier != "Mission")
				continue
			var/turf/meteor_turf = locate(T.x + rand(-VIEW_RANGE*2,VIEW_RANGE*2),T.y+rand(-VIEW_RANGE*2,VIEW_RANGE*2),T.z)
			if(meteor_turf)
				new /obj/effect/falling_meteor(meteor_turf)
				CHECK_TICK(50,FPS_SERVER*10)

	. = ..()

/event/meteors/on_end()
	log_debug("Ending Meteor Event")
	return ..()