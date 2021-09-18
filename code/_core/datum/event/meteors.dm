/event/meteors
	name = "Meteor Shower"

	probability = 10 //relative
	duration = SECONDS_TO_DECISECONDS(60)

	var/list/turf/valid_turfs = list()
	var/list/area/valid_areas = list()

	occurances_max = 5

/event/meteors/Destroy()
	valid_turfs?.Cut()
	valid_areas?.Cut()
	return ..()

/event/meteors/New()

	for(var/area/A in world)
		if(!A)
			continue
		if(A.area_identifier != "Mission")
			continue
		if(A.interior)
			continue
		if(A.flags_area & FLAGS_AREA_NO_EVENTS)
			continue
		valid_areas += A

	log_debug("Found [length(valid_turfs)] valid turfs for meteors event.")

	return ..()

/event/meteors/on_start()

	valid_turfs.Cut()

	log_debug("Starting Meteor Event")

	var/start_time = world.time

	for(var/k in valid_areas)
		CHECK_TICK(25,FPS_SERVER*10)
		var/area/A = k
		for(var/turf/T in A.contents)
			CHECK_TICK(25,FPS_SERVER*10)
			if(T.is_safe_teleport(FALSE))
				valid_turfs[T] = TRUE

	if(!length(valid_turfs))
		return FALSE

	announce(
		"Central Command Meteorology Division",
		"Meteor Storm Inbound",
		"Meteors have been detected near the area of operations.",
		sound_to_play = 'sound/voice/announcement/meteors.ogg'
	)

	log_debug("Took [world.time - start_time] deciseconds to initialize meteor turfs.")

	return ..()

/event/meteors/on_life()

	if(lifetime >= SECONDS_TO_DECISECONDS(10))
		CHECK_TICK(50,FPS_SERVER*10)
		for(var/i=1,i<=3,i++)
			var/turf/T = pick(valid_turfs)
			new/obj/effect/falling_meteor(T)
		var/number_of_players = length(all_players)
		if(number_of_players >= 10 && prob(number_of_players*0.25))
			var/mob/living/advanced/player/P = pick(all_players)
			if(!P.dead)
				var/turf/T = get_turf(P)
				if(T && valid_turfs[T])
					new/obj/effect/falling_meteor(T)

	. = ..()

/event/meteors/on_end()
	log_debug("Ending Meteor Event")
	return ..()