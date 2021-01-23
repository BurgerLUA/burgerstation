/mob/living/simple/goliath/broodmother
	name = "goliath broodmother"
	boss_icon_state = "broodmother"
	icon = 'icons/mob/living/simple/lavaland/goliath_broodmother.dmi'
	icon_state = "broodmother"
	damage_type = /damagetype/unarmed/claw/
	class = /class/goliath/broodmother

	ai = /ai/goliath/broodmother

	value = 1000

	stun_angle = 0

	health_base = 2500

	var/boss_state = 0
	//0 = walking
	//1 = flying
	//2 = landing

	attack_range = 1

	force_spawn = TRUE
	boss = TRUE

	status_immune = list(
		STUN = TRUE,
		SLEEP = TRUE,
		PARALYZE = TRUE,
		STAMCRIT = TRUE,
		STAGGER = TRUE,
		CONFUSED = TRUE,
		CRIT = TRUE,
		REST = TRUE,
		ADRENALINE = TRUE,
		DISARM = TRUE,
		DRUGGY = TRUE,
		FIRE = TRUE
	)

	butcher_contents = list(
		/obj/item/clothing/overwear/armor/bone,
		/obj/item/soapstone/orange,
		/obj/item/weapon/ranged/magic/tome/summon/goliath
	)

	fatigue_from_block_mul = 0

	mob_size = MOB_SIZE_BOSS

	enable_medical_hud = FALSE
	enable_security_hud = FALSE

	var/list/mob/living/simple/goliath/baby/tracked_babies = list()

	butcher_contents = list(
		/obj/item/container/food/dynamic/meat/raw_goliath,
		/obj/item/container/food/dynamic/meat/raw_goliath,
		/obj/item/container/food/dynamic/meat/raw_goliath,
		/obj/item/container/food/dynamic/meat/raw_goliath,
		/obj/item/container/food/dynamic/meat/raw_goliath,
		/obj/item/container/food/dynamic/meat/raw_goliath,
		/obj/item/container/food/dynamic/meat/raw_goliath,
		/obj/item/container/food/dynamic/meat/raw_goliath,
		/obj/item/container/food/dynamic/meat/raw_goliath
	)

/mob/living/simple/goliath/broodmother/post_death()
	. = ..()
	CREATE(/obj/structure/interactive/crate/necro/broodmother,get_turf(src))
	return .

/mob/living/simple/goliath/broodmother/on_life()
	. = ..()

	if(!dead && initialized)
		for(var/k in tracked_babies)
			var/mob/living/simple/goliath/baby/B = k
			if(B.dead || B.qdeleting)
				tracked_babies -= B
			if(ai && ai.objective_attack && B.ai && !B.ai.objective_attack)
				B.ai.set_objective(ai.objective_attack)
		if(length(tracked_babies) <= 4 && prob(20))
			var/turf/spawning_turf = get_step(src,pick(DIRECTIONS_ALL))
			var/mob/living/simple/goliath/baby/B = new(spawning_turf)
			INITIALIZE(B)
			GENERATE(B)
			FINALIZE(B)
			tracked_babies += B

	return .