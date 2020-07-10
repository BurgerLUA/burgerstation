/mob/living/simple/npc/can_man
	name = "Can Man"
	id = "can_man"
	icon = 'icons/mob/living/simple/canman.dmi'
	icon_state = "living"
	damage_type = /damagetype/unarmed/claw/
	class = /class/ash_drake

	value = 20000

	pixel_w = -8

	ai = /ai/boss/can_man

	stun_angle = 0

	health_base = 7500

	attack_range = 2

	force_spawn = TRUE
	boss = TRUE

	armor_base = list(
		BLADE = 75,
		BLUNT = 75,
		PIERCE = 75,
		LASER = 100,
		MAGIC = 25,
		HEAT = 75,
		COLD = 100,
		BOMB = 50,
		BIO = INFINITY,
		RAD = INFINITY,
		HOLY = INFINITY,
		DARK = INFINITY,
		FATIGUE = INFINITY
	)

	damage_received_multiplier = 0.5

	status_immune = list(
		STUN = STAGGER,
		SLEEP = STAGGER,
		PARALYZE = STAGGER,
		FATIGUE = STAGGER,
		DISARM = TRUE,
		FIRE = TRUE
	)

	mob_size = MOB_SIZE_BOSS

	enable_medical_hud = FALSE
	enable_security_hud = FALSE

	boss_music = "cursed_as_love"

	loyalty_tag = "Syndicate"
	iff_tag = "Syndicate"

	var/charge_steps = 0
	var/charge_dir = 0

	blood_color = "#262626"

	change_dir_on_move = FALSE

	movement_delay = DECISECONDS_TO_TICKS(6)

/mob/living/simple/npc/can_man/post_death()
	. = ..()
	charge_steps = 0
	charge_dir = 0
	icon_state = "dead"
	update_sprite()

/mob/living/simple/npc/can_man/get_movement_delay()

	. = ..()

	if(charge_steps)
		. = DECISECONDS_TO_TICKS(AI_TICK)

	return .

/mob/living/simple/npc/can_man/post_move(var/atom/old_loc)

	if(charge_steps)
		play('sound/effects/impacts/meteor_impact.ogg',get_turf(src))

	return ..()

/mob/living/simple/npc/can_man/Bump(var/atom/obstacle,var/Dir=0)

	if(charge_steps && is_living(obstacle))
		var/damagetype/DT = all_damage_types[/damagetype/npc/bubblegum]
		var/list/params = list()
		params[PARAM_ICON_X] = rand(0,32)
		params[PARAM_ICON_Y] = rand(0,32)
		var/atom/object_to_damage = obstacle.get_object_to_damage(src,src,params,TRUE,TRUE)
		DT.do_damage(src,obstacle,src,object_to_damage,src,1)
		return TRUE

	return ..()


/mob/living/simple/npc/can_man/proc/start_charge()
	charge_dir = dir
	charge_steps = rand(5,15)
	CALLBACK("stop_charge_\ref[src]",SECONDS_TO_DECISECONDS(2),src,.proc/finish_charge)
	return TRUE

/mob/living/simple/npc/can_man/proc/finish_charge()
	charge_dir = 0
	charge_steps = 0
	CALLBACK_REMOVE("stop_charge_\ref[src]")
	return TRUE






