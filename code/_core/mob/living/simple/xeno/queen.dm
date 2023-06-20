var/mob/living/simple/xeno/queen/tracked_xeno_queen

/mob/living/simple/xeno/queen
	name = "xeno queen"
	boss_icon_state = "xeno_queen"
	icon = 'icons/mob/living/simple/alien_queen.dmi'
	icon_state = "living"

	health_base = 5000
	stamina_base = 3000
	mana_base = 500

	pixel_x = -32

	value = 2000

	status_immune = list(
		STUN = TRUE,
		SLEEP = TRUE,
		PARALYZE = TRUE,
		STAMCRIT = TRUE,
		STAGGER = TRUE,
		CONFUSED = TRUE,
		DISARM = TRUE,
		FIRE = TRUE,
		GRAB = TRUE,
		PAINCRIT = TRUE
	)

	ai = /ai/boss/xeno_queen
	damage_type = /damagetype/npc/xeno/queen


	boss = TRUE
	force_spawn = TRUE

	movement_delay = DECISECONDS_TO_TICKS(4)

	butcher_contents = list(
		/obj/item/soapstone/orange,
		/obj/item/container/edible/dynamic/meat/raw_xeno/,
		/obj/item/container/edible/dynamic/meat/raw_xeno/,
		/obj/item/container/edible/dynamic/meat/raw_xeno/,
		/obj/item/container/edible/dynamic/meat/raw_xeno/,
		/obj/item/container/edible/dynamic/meat/raw_xeno/
	)

	fatigue_mul = 0

	size = SIZE_BOSS

	enable_medical_hud = FALSE
	enable_security_hud = FALSE

	can_leap = FALSE
	can_spit = TRUE

	death_sounds = FALSE

	var/next_screech = 0

	blood_type = /reagent/blood/xeno
	blood_volume = 4000

	soul_size = SOUL_SIZE_RARE

	object_size = 2

	respawn_time = SECONDS_TO_DECISECONDS(300)

	level = 30

/mob/living/simple/xeno/queen/PostInitialize()

	if(tracked_xeno_queen && tracked_xeno_queen == src)
		tracked_xeno_queen = null
	return ..()


/mob/living/simple/xeno/queen/PreDestroy()

	if(tracked_xeno_queen && tracked_xeno_queen == src)
		tracked_xeno_queen = null

	return ..()

/mob/living/simple/xeno/queen/post_death()

	. = ..()

	play_sound('sound/voice/xeno/queen_death.ogg',get_turf(src))

	tracked_xeno_queen = null

/mob/living/simple/xeno/queen/proc/inhale()
	do_say("&#42;inhales&#42;",should_sanitize = FALSE)
	CALLBACK("queen_screech_\ref[src]",SECONDS_TO_DECISECONDS(4),src,src::screech())
	return TRUE

/mob/living/simple/xeno/queen/proc/screech()

	do_say("AAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAA")

	var/turf/T = get_turf(src)

	play_sound('sound/voice/xeno/queen_screech.ogg',T, range_min = VIEW_RANGE, range_max = VIEW_RANGE*3)

	for(var/mob/living/L in view(VIEW_RANGE,src))
		if(L.dead)
			continue
		if(!allow_hostile_action(src.loyalty_tag,L))
			continue
		L.add_status_effect(STUN,20,20)

	var/obj/marker/map_node/N_end = find_closest_node(src)

	if(N_end)
		for(var/mob/living/simple/xeno/X in SSliving.all_living)
			CHECK_TICK(75,FPS_SERVER)
			if(X == src)
				continue
			if(X.dead || !X.ai)
				continue
			var/obj/marker/map_node/N_start = find_closest_node(X)
			if(!N_start)
				continue
			var/list/obj/marker/map_node/found_path = AStar_Circle_node(N_start,N_end)
			if(!found_path)
				continue
			X.ai.set_path_node(found_path)

	return TRUE