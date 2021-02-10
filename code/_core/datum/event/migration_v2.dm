/event/migration
	name = "Migration"

	probability = 20 //relative

	var/list/turf/valid_turfs = list()
	var/list/area/valid_areas = list()

	occurances_max = 10

	var/list/possible_enemy_types = list(
		/mob/living/advanced/npc/ashwalker/hunter,
		/mob/living/advanced/npc/beefman,
		/mob/living/advanced/npc/pirate_crew/magic,
		/mob/living/advanced/npc/rev,
		/mob/living/advanced/npc/sorcerer,
		/mob/living/advanced/npc/syndicate/quadruple,
		/mob/living/simple/arachnid,
		/mob/living/simple/bear/space,
		/mob/living/simple/bull,
		/mob/living/simple/crab,
		/mob/living/simple/goliath,
		/mob/living/simple/spacecarp,
		/mob/living/simple/spider,
		/mob/living/simple/venus_human_trap,
		/mob/living/simple/watcher,
		/mob/living/simple/xeno/hunter
	)

	var/mob/living/enemy_type_to_spawn

/event/migration/Destroy()
	valid_turfs.Cut()
	valid_areas.Cut()
	return ..()

/event/migration/New()

	for(var/area/A in world)
		if(A.area_identifier != "Mission")
			continue
		if(A.interior)
			continue
		if(A.flags_area & FLAGS_AREA_NO_EVENTS)
			continue
		valid_areas += A

	log_debug("Found [length(valid_areas)] valid areas for migration event.")

	return ..()

/event/migration/on_start()

	valid_turfs.Cut()

	log_debug("Starting Migration Event")

	enemy_type_to_spawn = pick(possible_enemy_types)

	var/list/announce_areas = list()

	for(var/i=1,i<=rand(1,3),i++)
		if(!length(valid_areas))
			return FALSE
		var/area/A = pick(valid_areas)
		announce_areas |= A.name
		for(var/turf/simulated/floor/T in A.contents)
			if(T.x <= 10 || T.x >= WORLD_SIZE - 10)
				continue
			if(T.y <= 10 || T.y >= WORLD_SIZE - 10)
				continue
			valid_turfs += T

	if(!length(valid_turfs))
		return FALSE

	var/the_name = initial(enemy_type_to_spawn.name)

	announce(
		"Central Command Space Biology Division",
		"[the_name] Migration",
		"A [the_name] migration has been detected near the area of operations. Predicted migration areas: [english_list(announce_areas)].",
		sound_to_play = 'sound/voice/announcement/migration.ogg'
	)

	for(var/i=1,i<=20,i++)
		CHECK_TICK(50,FPS_SERVER*10)
		if(!length(valid_turfs))
			break
		var/turf/T = pick(valid_turfs)
		if(!T)
			break
		CREATE_SAFE(enemy_type_to_spawn,T)

	return ..()

/event/migration/on_end()
	log_debug("Ending Migration Event")
	return ..()