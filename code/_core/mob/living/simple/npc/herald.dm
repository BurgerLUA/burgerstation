/mob/living/simple/npc/herald
	name = "herald of Sleeping Carp"
	id = "herald"
	icon = 'icons/mob/living/simple/lavaland/herald.dmi'
	icon_state = "living"
	damage_type = /damagetype/cqc/sleeping_carp/gnashing_teeth
	class = /class/herald/
	ai = /ai/boss/herald/
	value = 3000

	health_base = 2000

	move_delay = 1

	stun_angle = 0

	attack_range = 1

	force_spawn = TRUE
	boss = TRUE

	armor_base = list(
		BLADE = 25,
		BLUNT = 75,
		PIERCE = 75,
		LASER = 75,
		ARCANE = 50,
		HEAT = 75,
		COLD = 25,
		BOMB = 25,
		BIO = 50,
		RAD = 50,
		HOLY = -25,
		DARK = 75,
		FATIGUE = 75,
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
		FIRE = TRUE
	)

	iff_tag = "Herald"
	loyalty_tag = "Herald"

	fatigue_from_block_mul = 0

	mob_size = MOB_SIZE_BOSS

	sprint_delay_mul = 1
	jog_delay_mul = 3
	walk_delay_mul = 4

	enable_medical_hud = FALSE
	enable_security_hud = FALSE

	var/next_teleport = 0


/mob/living/simple/npc/herald/get_damage_type(var/atom/attacker,var/atom/victim)

	if( (next_teleport - world.time) >= SECONDS_TO_DECISECONDS(2) )
		return /damagetype/cqc/sleeping_carp/crashing_wave_kick

	if(attacker && victim && get_dir(attacker,victim) == victim.dir )
		return /damagetype/cqc/sleeping_carp/keelhaul

	return ..()

/mob/living/simple/npc/herald/post_death()
	. = ..()
	CREATE(/obj/structure/interactive/crate/necro,get_turf(src))
	animate(src, pixel_z = 64, time = 30)
	icon_state = "dead"
	update_sprite()
	return .

/mob/living/simple/npc/herald/proc/teleport_random()

	var/list/valid_turfs = list()

	for(var/turf/simulated/floor/F in range(6,src))
		valid_turfs += F

	if(!length(valid_turfs))
		return FALSE

	var/turf/T = pick(valid_turfs)
	new /obj/effect/temp/sparkles(src.loc)
	force_move(T)
	new /obj/effect/temp/sparkles(src.loc)

	src.next_teleport = world.time + SECONDS_TO_DECISECONDS(3)

	return TRUE

/mob/living/simple/npc/herald/proc/teleport_target(var/atom/target)

	if(!target)
		return FALSE

	var/turf/T = get_step(target,turn(target.dir,180))

	if(!T)
		return FALSE

	new /obj/effect/temp/sparkles(src.loc)
	force_move(T)
	new /obj/effect/temp/sparkles(src.loc)

	src.next_teleport = world.time + SECONDS_TO_DECISECONDS(3)

	return TRUE


/mob/living/simple/npc/herald/pre_death()
	play('sound/effects/demon_dies.ogg',get_turf(src), volume=75, range_min = VIEW_RANGE, range_max = VIEW_RANGE * 3)
	return ..()

/mob/living/simple/npc/herald/handle_alpha()
	if(dead)
		return 0
	return ..()