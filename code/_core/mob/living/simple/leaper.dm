/mob/living/simple/leaper
	name = "leaper"
	boss_icon_state = "leaper"
	icon = 'icons/mob/living/simple/jungle/leaper.dmi'
	icon_state = "living"
	damage_type = /damagetype/unarmed/claw/


	pixel_x = -16

	value = 5000

	ai = /ai/boss/leaper

	butcher_contents = list(

	)

	stun_angle = 0

	health_base = 15000
	stamina_base = 1000
	mana_base = 2000

	boss_loot = /loot/lavaland/leaper

	force_spawn = TRUE
	boss = TRUE

	armor_base = list(
		BLADE = 20,
		BLUNT = 20,
		PIERCE = 40,
		LASER = 80,
		ARCANE = 20,
		HEAT = 80,
		COLD = -40,
		BIO = 120,
		RAD = 120,
		HOLY = -20,
		DARK = 120,
		FATIGUE = 120,
		ION = INFINITY,
		PAIN = 20
	)

	fatigue_mul = 0

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
		DRUGGY = TRUE
	)

	size = SIZE_BOSS

	enable_medical_hud = FALSE
	enable_security_hud = FALSE

	iff_tag = "Jungle"
	loyalty_tag = "Jungle"

	blood_type = /reagent/blood/ancient
	blood_volume = 3000

	soul_size = SOUL_SIZE_RARE

	anchored = TRUE

	object_size = 2

	respawn_time = SECONDS_TO_DECISECONDS(300)

	level = 20

/mob/living/simple/leaper/handle_alpha()
	if(immortal)
		return 0
	. = ..()

/mob/living/simple/leaper/post_death()
	..()
	icon_state = "dead"
	update_sprite()
	anchored = FALSE

/mob/living/simple/leaper/proc/try_teleport()

	if(CALLBACK_EXISTS("\ref[src]_leaper_teleport"))
		return FALSE

	var/list/valid_turfs = list()

	var/turf_limit = (VIEW_RANGE*VIEW_RANGE)*0.25
	for(var/turf/simulated/floor/T in view(VIEW_RANGE,src))
		CHECK_TICK(50,FPS_SERVER)
		turf_limit--
		if(turf_limit <= 0)
			break
		if(get_dist(T,src) <= 2)
			continue
		if(!T.is_safe_teleport())
			continue
		valid_turfs += T

	if(!length(valid_turfs))
		return FALSE

	var/turf/desired_turf = pick(valid_turfs)

	immortal = TRUE
	density = FALSE
	CALLBACK("\ref[src]_leaper_teleport",10,src,.proc/teleport,desired_turf)

	return TRUE

/mob/living/simple/leaper/proc/teleport(var/turf/desired_turf)

	if(desired_turf) src.force_move(desired_turf)
	immortal = FALSE
	density = TRUE

	return TRUE


/mob/living/simple/leaper/proc/volley_bubbles()

	if(!ai || !ai.objective_attack)
		return FALSE

	if(CALLBACK_EXISTS("\ref[src]_shoot_bubble5"))
		return FALSE

	for(var/i=1,i<=3,i++)
		CALLBACK("\ref[src]_shoot_bubble[i]",5+i*6,src,.proc/shoot_bubble,ai.objective_attack)

	return TRUE

/mob/living/simple/leaper/proc/spam_bubbles()

	for(var/mob/living/L in view(VIEW_RANGE,src))
		if(L.dead)
			continue
		if(L.iff_tag == src.iff_tag)
			continue
		shoot_bubble(L,play_sound=FALSE)

	play_sound('sound/weapons/magic/generic_conjure_multi.ogg',get_turf(src),volume=75)

	return TRUE

/mob/living/simple/leaper/proc/shoot_bubble(var/atom/desired_target,var/play_sound=TRUE)

	if(dead)
		return FALSE

	if(!desired_target || desired_target.qdeleting || desired_target.z != src.z)
		return FALSE

	flick("shoot",src)

	shoot_projectile(
		src,
		desired_target,
		null,
		null,
		/obj/projectile/leaper,
		/damagetype/ranged/leaper_bubble,
		16,
		16,
		0,
		TILE_SIZE*0.5,
		1,
		"#FFFFFF",
		0,
		0,
		1,
		iff_tag,
		loyalty_tag
	)

	if(play_sound)
		play_sound('sound/weapons/magic/generic_conjure.ogg',get_turf(src))

	return TRUE





