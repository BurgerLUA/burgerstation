/mob/living/simple/npc/goliath/broodmother
	name = "goliath broodmother"
	id = "broodmother"
	icon = 'icons/mob/living/simple/lavaland/goliath_broodmother.dmi'
	icon_state = "broodmother"
	damage_type = /damagetype/unarmed/claw/
	class = /class/goliath/broodmother

	ai = /ai/goliath/broodmother

	value = 1000

	stun_angle = 0

	health_base = 3000

	var/boss_state = 0
	//0 = walking
	//1 = flying
	//2 = landing

	attack_range = 1

	force_spawn = TRUE
	boss = TRUE

	armor_base = list(
		BLADE = 75,
		BLUNT = 50,
		PIERCE = 50,
		LASER = 100,
		MAGIC = 0,
		HEAT = INFINITY,
		COLD = 0,
		BOMB = 75,
		BIO = 75,
		RAD = 75,
		HOLY = 25,
		DARK = INFINITY,
		FATIGUE = INFINITY
	)

	status_immune = list(
		STUN = TRUE,
		SLEEP = STAGGER,
		PARALYZE = STAGGER,
		FATIGUE = STAGGER,
		STAGGER = FALSE,
		CONFUSED = FALSE,
		CRIT = FALSE,
		REST = FALSE,
		ADRENALINE = FALSE,
		DISARM = FALSE,
		DRUGGY = FALSE,
		FIRE = FALSE
	)

	butcher_contents = list(
		/obj/item/clothing/overwear/armor/bone_armor,
		/obj/item/soapstone/orange
	)

	damage_received_multiplier = 0.5

	mob_size = MOB_SIZE_BOSS

	enable_medical_hud = FALSE
	enable_security_hud = FALSE

	var/list/mob/living/simple/npc/goliath/baby/tracked_babies = list()

/mob/living/simple/npc/goliath/broodmother/post_death()
	..()
	CREATE(/obj/structure/interactive/crate/necro,get_turf(src))


/mob/living/simple/npc/goliath/broodmother/on_life()
	. = ..()

	if(!dead && initialized)

		for(var/mob/living/simple/npc/goliath/baby/B in tracked_babies)
			if(B.dead || B.qdeleting)
				tracked_babies -= B
			if(ai && ai.objective_attack && B.ai && !B.ai.objective_attack)
				B.ai.set_objective(ai.objective_attack)

		for(var/i=1,i<=4-length(tracked_babies))
			var/turf/spawning_turf = get_step(src,pick(DIRECTIONS_ALL))
			var/mob/living/simple/npc/goliath/baby/B = new(spawning_turf)
			INITIALIZE(B)
			GENERATE(B)
			tracked_babies += B

	return .