var/mob/living/simple/npc/xeno/queen/tracked_xeno_queen

/mob/living/simple/npc/xeno/queen
	name = "xeno queen"
	id = "xeno_queen"
	icon = 'icons/mob/living/simple/alien_queen.dmi'
	icon_state = "living"
	pixel_x = -16
	health_base = 2000
	value = 2000

	armor_base = list(
		BLADE = 100,
		BLUNT = 75,
		PIERCE = 100,
		LASER = 50,
		ARCANE = 50,
		HEAT = 75,
		COLD = 75,
		BOMB = 50,
		BIO = INFINITY,
		RAD = INFINITY,
		HOLY = 75,
		DARK = 100,
		FATIGUE = 50,
		ION = INFINITY
	)

	status_immune = list(
		STUN = TRUE,
		SLEEP = TRUE,
		PARALYZE = TRUE,
		FATIGUE = TRUE,
		STAGGER = TRUE,
		CONFUSED = TRUE,
		CRIT = TRUE,
		REST = TRUE,
		ADRENALINE = TRUE,
		DISARM = TRUE,
		DRUGGY = TRUE,
		FIRE = FALSE
	)

	ai = /ai/xeno
	damage_type = /damagetype/npc/xeno/queen
	class = /class/xeno

	boss = TRUE
	force_spawn = TRUE

	movement_delay = DECISECONDS_TO_TICKS(2)

	level_multiplier = 10

	butcher_contents = list(
		/obj/item/soapstone/orange,
		/obj/item/container/food/dynamic/meat/xeno/,
		/obj/item/container/food/dynamic/meat/xeno/,
		/obj/item/container/food/dynamic/meat/xeno/,
		/obj/item/container/food/dynamic/meat/xeno/,
		/obj/item/container/food/dynamic/meat/xeno/
	)

	fatigue_from_block_mul = 0

	mob_size = MOB_SIZE_BOSS

	enable_medical_hud = FALSE
	enable_security_hud = FALSE

	can_leap = FALSE
	can_spit = TRUE

	death_sounds = FALSE

	var/next_screech = 0

/mob/living/simple/npc/xeno/queen/PostInitialize()

	if(tracked_xeno_queen && tracked_xeno_queen == src)
		tracked_xeno_queen = null
	return ..()


/mob/living/simple/npc/xeno/queen/Destroy()

	if(tracked_xeno_queen && tracked_xeno_queen == src)
		tracked_xeno_queen = null

	return ..()

/mob/living/simple/npc/xeno/queen/post_death()

	. = ..()

	play('sound/voice/xeno/queen_death.ogg',get_turf(src))

	tracked_xeno_queen = null

	return .

/mob/living/simple/npc/xeno/queen/proc/screech(var/debug = FALSE)

	var/obj/marker/map_node/N_end = find_closest_node(src)

	play('sound/voice/xeno/queen_screech.ogg',get_turf(src), range_min = VIEW_RANGE, range_max = VIEW_RANGE*3)

	for(var/mob/living/L in range(src,VIEW_RANGE))
		if(L.loyalty_tag == src.loyalty_tag)
			continue
		L.add_status_effect(STUN,40,40)

	if(N_end)
		var/created_paths = 0
		var/failed_paths = 0
		for(var/mob/living/simple/npc/xeno/X in all_living)
			CHECK_TICK(75,FPS_SERVER)
			if(X == src)
				continue
			if(X.dead || !X.ai)
				continue
			var/obj/marker/map_node/N_start = find_closest_node(X)
			if(!N_start)
				failed_paths++
				continue
			var/obj/marker/map_node/list/found_path = N_start.find_path(N_end)
			if(!found_path)
				failed_paths++
				continue
			X.ai.set_path(found_path)
			created_paths++
		log_error("Screech: Found [created_paths] valid pathsa and [failed_paths] failed paths.")
	else if(debug)
		log_error("Could not find path end for [src.get_debug_name()] queen screech!")

	return TRUE