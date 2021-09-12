/mob/living/simple/hierophant
	name = "hierophant"
	boss_icon_state = "hierophant"
	icon = 'icons/mob/living/simple/hierophant.dmi'
	icon_state = "living"
	boss = TRUE
	damage_type = /damagetype/melee/club/mace


	ai = /ai/boss/hierophant/

	stun_angle = 90

	health_base = 10000

	armor_base = list(
		ION = INFINITY
	)

	boss_loot = /loot/lavaland/hierophant

	fatigue_mul = 0

	size = SIZE_BOSS

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

	enable_medical_hud = FALSE
	enable_security_hud = FALSE

	iff_tag = "Hierophant"
	loyalty_tag = "Hierophant"

	blood_type = /reagent/blood/ancient
	blood_volume = 3000

	soul_size = SOUL_SIZE_RARE

	movement_delay = DECISECONDS_TO_TICKS(6)

	level = 50


/mob/living/simple/hierophant/proc/chain_blast_random()

	var/teleport_num = rand(1,8)

	for(var/i=1,i<=8,i++)
		var/desired_dir = DIRECTIONS_ALL[i]
		var/turf/T = get_step(src,desired_dir)
		var/obj/effect/temp/hazard/hierophant/H = new(T,7,src)
		H.dir = get_true_4dir(desired_dir)
		H.copy_delay = 1 + 2*max(0,health.health_current/health.health_max)
		if(i == teleport_num)
			H.should_teleport = TRUE
		INITIALIZE(H)

	return TRUE

/mob/living/simple/hierophant/proc/chain_blast_targets()

	var/teleport_num = rand(1,8)

	var/i=1
	for(var/mob/living/L in view(VIEW_RANGE,src))
		if(L.loyalty_tag == src.loyalty_tag)
			continue
		if(L.dead)
			continue
		var/desired_dir = DIRECTIONS_ALL[i]
		var/turf/T = get_step(src,desired_dir)
		var/obj/effect/temp/hazard/hierophant/targeted/H = new(T,7,src)
		H.target = L
		H.dir = get_true_4dir(desired_dir)
		H.copy_delay = 1 + 2*max(0,health.health_current/health.health_max)
		if(i == teleport_num)
			H.should_teleport = TRUE
		INITIALIZE(H)
		i++
		if(i>=8)
			break

	return TRUE

/mob/living/simple/hierophant/proc/blast_all() //This is too laggy.

	var/mode = rand(1,3)

	for(var/turf/T in range(VIEW_RANGE*0.5,src))
		if(mode == 1)
			if(T.x % 2 || T.y % 2)
				continue
		if(mode == 2)
			if(!(T.x % 2) || !(T.y % 2))
				continue
		if(mode == 3)
			if(T.x % 2 && T.y % 2)
				continue
		var/obj/effect/temp/hazard/hierophant/single/S = new(T,7,src)
		S.dir = pick(DIRECTIONS_CARDINAL)
		INITIALIZE(S)

	return TRUE


/mob/living/simple/hierophant/post_death()
	icon_state = "dead"
	return ..()