/mob/living/simple/ash_drake
	name = "ash drake"
	boss_icon_state = "ash_drake"
	icon = 'icons/mob/living/simple/lavaland/ashdrake.dmi'
	icon_state = "living"
	damage_type = /damagetype/unarmed/claw/


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

	health_base = 10000
	stamina_base = 5000
	mana_base = 5000

	boss_loot = /loot/lavaland/ash_drake

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
		FIRE = TRUE
	)

	size = SIZE_BOSS

	enable_medical_hud = FALSE
	enable_security_hud = FALSE

	iff_tag = "Ash Drake"
	loyalty_tag = "Ash Drake"

	blood_type = /reagent/blood/ancient
	blood_volume = 3000

	soul_size = SOUL_SIZE_MYSTIC

	object_size = 2

	respawn_time = SECONDS_TO_DECISECONDS(300)

	level = 50

	movement_delay = DECISECONDS_TO_TICKS(5)



/mob/living/simple/ash_drake/can_attack(var/atom/attacker,var/atom/victim,var/atom/weapon,var/params,var/damagetype/damage_type)

	if(boss_state)
		return FALSE

	. = ..()

/mob/living/simple/ash_drake/can_be_attacked(var/atom/attacker,var/atom/weapon,var/params,var/damagetype/damage_type)

	if(boss_state)
		return FALSE

	. = ..()

/mob/living/simple/ash_drake/proc/fly()

	if(boss_state)
		return

	if(prob(50))
		fire_rain()

	var/turf/T = get_turf(src)

	new/obj/effect/temp/ash_drake/swoop_up(T)

	boss_state = 1
	update_collisions(FLAG_COLLISION_NONE,FLAG_COLLISION_BULLET_NONE)
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

	CALLBACK("\ref[src]_ash_drake_land",SECONDS_TO_DECISECONDS(1),src,.proc/finish_land)

	if(prob(50))
		fire_rain()

	return TRUE



/mob/living/simple/ash_drake/proc/finish_land()

	boss_state = 0
	icon_state = "living"
	update_collisions(initial(collision_flags),initial(collision_bullet_flags))
	interaction_flags = initial(interaction_flags)
	update_sprite()

	play_sound('sound/mob/ash_drake/impact.ogg',get_turf(src))

	for(var/turf/T in range(2,src))
		new/obj/effect/temp/impact/combat/smash(T)
		var/is_center = T == src.loc
		for(var/mob/living/L in T.contents)
			L.add_status_effect(STAGGER,10 + is_center*30,10 + is_center*30,source = src)

	return TRUE




/mob/living/simple/ash_drake/proc/fire_rain()

	if(!health)
		return FALSE

	var/list/turf/simulated/floor/valid_floors = list()

	var/turf/desired_turf = ai && ai.objective_attack ? get_turf(ai.objective_attack) : get_turf(src)

	for(var/turf/simulated/floor/T in range(4,desired_turf))
		valid_floors += T

	if(length(valid_floors))
		var/amount_multiplier = FLOOR(5 + (1 - (health.health_current/health.health_max))*15, 1)
		play_sound('sound/mob/ash_drake/firerain.ogg',desired_turf)
		for(var/i=1,i<=amount_multiplier,i++)
			var/turf/T = pick(valid_floors)
			new/obj/effect/temp/target(T)
			new/obj/effect/falling_fireball(T)

	return TRUE

/mob/living/simple/ash_drake/get_movement_delay(var/include_stance=TRUE)

	if(boss_state)
		return 1

	. = ..()

/mob/living/simple/ash_drake/proc/shoot_fireball(var/atom/desired_target)
	shoot_projectile(
		src,
		desired_target,
		null,
		null,
		/obj/projectile/magic/fireball/lava,
		/damagetype/ranged/magic/fireball,
		16,
		16,
		0,
		TILE_SIZE*0.25,
		1,
		"#FFFFFF",
		0,
		1,
		iff_tag,
		loyalty_tag
	)
	play_sound('sound/mob/ash_drake/fireball.ogg',get_turf(src))

/mob/living/simple/ash_drake/post_death()
	. = ..()
	icon_state = "dead"
	update_sprite()
	play_sound('sound/mob/ash_drake/death.ogg',get_turf(src))







