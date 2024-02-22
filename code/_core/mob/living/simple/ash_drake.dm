/mob/living/simple/ash_drake
	name = "ash drake"
	boss_icon_state = "ash_drake"
	icon = 'icons/mob/living/simple/lavaland/ashdrake.dmi'
	icon_state = "living"
	damage_type = /damagetype/unarmed/claw

	pixel_x = -16

	value = 6000

	ai = /ai/boss/ash_drake/

	butcher_contents = list(
		/obj/item/container/edible/dynamic/meat/raw_ash_drake,
		/obj/item/container/edible/dynamic/meat/raw_ash_drake,
		/obj/item/container/edible/dynamic/meat/raw_ash_drake,
		/obj/item/container/edible/dynamic/meat/raw_ash_drake,
		/obj/item/container/edible/dynamic/meat/raw_ash_drake,
		/obj/item/container/edible/dynamic/meat/raw_ash_drake
	)

	stun_angle = 0

	health_base = 12500
	stamina_base = 5000
	mana_base = 5000

	boss_loot = /loot/lavaland/ash_drake

	boss_music = /track/it_swoops

	var/boss_state = 0
	//0 = walking
	//1 = flying
	//2 = landing

	force_spawn = TRUE
	boss = TRUE

	armor = /armor/drake

	fatigue_mul = 0

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

	size = SIZE_BOSS

	enable_medical_hud = FALSE
	enable_security_hud = FALSE

	iff_tag = "Ash Drake"
	loyalty_tag = "Ash Drake"

	blood_type = /reagent/blood/ancient
	blood_volume = 2000

	soul_size = SOUL_SIZE_MYSTIC

	object_size = 2

	respawn_time = SECONDS_TO_DECISECONDS(300)

	level = 28

	movement_delay = DECISECONDS_TO_TICKS(4)

	var/next_special_move = 0

/mob/living/simple/ash_drake/can_attack(var/atom/attacker,var/atom/victim,var/atom/weapon,var/params,var/damagetype/damage_type)
	if(boss_state)
		return FALSE
	. = ..()

/mob/living/simple/ash_drake/can_be_attacked(var/atom/attacker,var/atom/weapon,var/params,var/damagetype/damage_type)
	if(boss_state)
		return FALSE
	. = ..()

/mob/living/simple/ash_drake/proc/start_fly()

	if(boss_state)
		return

	var/turf/T = get_turf(src)

	for(var/obj/fire_process/FP in orange(2,src))
		FP.momentum = get_dir(src,FP)

	new/obj/effect/temp/ash_drake/swoop_up(T)

	boss_state = 1
	update_collisions(FLAG_COLLISION_FLYING,FLAG_COLLISION_BULLET_NONE)
	interaction_flags = 0x0
	icon_state = "shadow"
	play_sound('sound/mob/ash_drake/fly.ogg',T)
	update_sprite()

/mob/living/simple/ash_drake/proc/start_land()

	if(boss_state != 1)
		return FALSE

	var/turf/T = get_turf(src)

	new/obj/effect/temp/ash_drake/swoop_down(T)
	boss_state = 2

	play_sound('sound/mob/ash_drake/land.ogg',T)

	CALLBACK("\ref[src]_ash_drake_land",SECONDS_TO_DECISECONDS(1),src,src::finish_land())

	if(prob(50))
		fire_rain()

	return TRUE



/mob/living/simple/ash_drake/proc/finish_land()

	boss_state = 0
	icon_state = "living"
	update_collisions(initial(collision_flags),initial(collision_bullet_flags))
	interaction_flags = initial(interaction_flags)
	update_sprite()

	var/turf/center_turf = get_turf(src)

	play_sound('sound/mob/ash_drake/impact.ogg',center_turf)

	for(var/turf/simulated/T in range(3,center_turf)) //7x7
		new/obj/effect/temp/impact/combat/smash(T)
		var/is_center = get_dist(center_turf,T) <= 1 //3x3
		for(var/mob/living/L in T.contents)
			if(L==src)
				continue
			L.add_status_effect(is_center ? STUN : STAGGER,20 + is_center*40,10 + is_center*30,source = src)
		if(T.health)
			T.health.adjust_loss_smart(brute=500)
		if(T != center_turf)
			var/obj/fire_process/FP = locate() in T.contents
			if(FP)
				FP.momentum = get_dir(src,FP)

	return TRUE




/mob/living/simple/ash_drake/proc/fire_rain()

	if(!health)
		return FALSE

	var/list/turf/simulated/floor/valid_floors = list()

	var/turf/desired_turf = ai && ai.objective_attack ? get_turf(ai.objective_attack) : get_turf(src)

	for(var/turf/simulated/floor/T in range(VIEW_RANGE*0.5,desired_turf))
		valid_floors += T

	if(length(valid_floors))
		var/amount_multiplier = FLOOR(5 + (1 - (health.health_current/health.health_max))*15, 1)
		play_sound('sound/mob/ash_drake/firerain.ogg',desired_turf)
		for(var/i=1,i<=amount_multiplier,i++)
			var/turf/T = pick(valid_floors)
			new/obj/effect/temp/target(T)
			new/obj/effect/falling_fireball(T)

	return TRUE

/mob/living/simple/ash_drake/get_movement_delay()

	if(boss_state)
		return AI_TICK_FAST

	. = ..()

/mob/living/simple/ash_drake/post_death()
	. = ..()
	if(.)
		icon_state = "dead"
		update_sprite()
		play_sound('sound/mob/ash_drake/death.ogg',get_turf(src))


/mob/living/simple/ash_drake/proc/start_fire_breath(var/atom/desired_target)

	if(has_status_effect(PARALYZE))
		return FALSE

	add_status_effect(PARALYZE,duration=40,magnitude=-1,stealthy=TRUE)

	play_sound('sound/mob/ash_drake/inhale.ogg',get_turf(src))

	var/turf/stored_turf = get_turf(desired_target)

	CALLBACK("\ref[src]_do_fire_breath",20,src,src::do_fire_breath(),desired_target,stored_turf)


/mob/living/simple/ash_drake/proc/do_fire_breath(var/atom/desired_target,var/turf/fallback_turf)

	var/do_bonus = FALSE

	var/atom/target_to_hit = desired_target

	if(src.dir & get_dir(src,desired_target))
		do_bonus = prob(20)
	else
		target_to_hit = fallback_turf
		do_bonus = TRUE

	shoot_projectile(
		src,
		target_to_hit,
		null,
		null,
		/obj/projectile/fire_breath,
		null,
		16,
		16,
		0,
		TILE_SIZE*0.4,
		1,
		"#FFFFFF",
		0,
		1,
		iff_tag,
		loyalty_tag
	)

	play_sound('sound/mob/ash_drake/exhale.ogg',get_turf(src))

	if(do_bonus)
		add_status_effect(PARALYZE,duration=20,magnitude=-1,stealthy=TRUE)
		CALLBACK("\ref[src]_do_bonus_dash",21,src,src::do_bonus_dash(),fallback_turf)

/mob/living/simple/ash_drake/proc/do_bonus_dash(var/atom/desired_dash_target)
	dash_target = desired_dash_target
	dash_amount = min(VIEW_RANGE,get_dist(src,dash_target))
	return TRUE