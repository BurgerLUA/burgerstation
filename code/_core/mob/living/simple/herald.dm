/mob/living/simple/herald
	name = "\improper Herald of Sleeping Carp"
	boss_icon_state = "herald"
	icon = 'icons/mob/living/simple/lavaland/herald.dmi'
	icon_state = "living"
	damage_type = /damagetype/unarmed/cqc/sleeping_carp/gnashing_teeth

	ai = /ai/boss/herald/
	value = 3000

	boss_loot = /loot/lavaland/herald

	boss_music = /track/herald

	health_base = 4500
	stamina_base = 2000
	mana_base = 100

	movement_delay = DECISECONDS_TO_TICKS(1)

	stun_angle = 0

	force_spawn = TRUE
	boss = TRUE

	armor = /armor/colossus

	iff_tag = "Herald"
	loyalty_tag = "Herald"

	fatigue_mul = 0

	size = SIZE_BOSS

	sprint_delay_mul = 1
	jog_delay_mul = 3
	walk_delay_mul = 4

	enable_medical_hud = FALSE
	enable_security_hud = FALSE

	var/next_teleport = 0

	blood_type = /reagent/blood/ancient
	blood_volume = 1000

	butcher_contents = list(
		/obj/item/container/edible/dynamic/meat/raw_colossus,
		/obj/item/container/edible/dynamic/meat/raw_colossus,
		/obj/item/container/edible/dynamic/meat/raw_colossus,
		/obj/item/container/edible/dynamic/meat/raw_colossus
	)

	soul_size = SOUL_SIZE_MYSTIC

	respawn_time = SECONDS_TO_DECISECONDS(300)

	level = 35


/mob/living/simple/herald/get_damage_type(var/atom/attacker,var/atom/victim)

	if( (next_teleport - world.time) >= SECONDS_TO_DECISECONDS(2) )
		return /damagetype/unarmed/cqc/sleeping_carp/crashing_wave_kick

	if(attacker && victim && !is_facing(victim,attacker))
		return /damagetype/unarmed/cqc/sleeping_carp/keelhaul

	return ..()

/mob/living/simple/herald/post_death()
	. = ..()
	animate(src, pixel_z = 64, time = 30)
	icon_state = "dead"
	update_sprite()

/mob/living/simple/herald/proc/teleport_random()

	var/list/valid_turfs = list()

	for(var/turf/simulated/floor/F in range(6,src))
		valid_turfs += F

	if(!length(valid_turfs))
		return FALSE

	var/turf/T = pick(valid_turfs)
	if(!istype(T))
		return FALSE


	new /obj/effect/temp/sparkles(src.loc)
	force_move(T)
	new /obj/effect/temp/sparkles(src.loc)

	src.next_teleport = world.time + SECONDS_TO_DECISECONDS(3)

	return TRUE

/mob/living/simple/herald/proc/teleport_target(var/atom/target)

	if(!target)
		return FALSE

	var/turf/T = get_step(target,turn(target.dir,180))

	if(!istype(T))
		return FALSE

	new /obj/effect/temp/sparkles(src.loc)
	force_move(T)
	new /obj/effect/temp/sparkles(src.loc)

	src.next_teleport = world.time + SECONDS_TO_DECISECONDS(3)

	return TRUE


/mob/living/simple/herald/pre_death()
	play_sound('sound/effects/demon_dies.ogg',get_turf(src), volume=75, range_min = VIEW_RANGE, range_max = VIEW_RANGE * 3)
	return ..()

/mob/living/simple/herald/handle_alpha()
	if(dead)
		return 0
	return ..()