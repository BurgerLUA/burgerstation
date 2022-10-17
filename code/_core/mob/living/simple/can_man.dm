/mob/living/simple/can_man
	name = "Can Man"
	boss_icon_state = "can_man"
	icon = 'icons/mob/living/simple/canman.dmi'
	icon_state = "living"
	damage_type = /damagetype/unarmed/claw/


	value = 20000

	ai = /ai/boss/can_man

	pixel_x = -8

	boss_loot = /loot/lavaland/can_man

	stun_angle = 0

	health_base = 10000
	stamina_base = 4000
	mana_base = 100

	force_spawn = TRUE
	boss = TRUE

	armor = /armor/borg/military
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
		DRUGGY = TRUE,
		FIRE = TRUE
	)

	size = SIZE_BOSS

	enable_medical_hud = FALSE
	enable_security_hud = FALSE

	//boss_music = "cursed_as_love"

	loyalty_tag = "Syndicate"
	iff_tag = "Syndicate"

	var/charge_steps = 0
	var/charge_dir = 0

	blood_type = /reagent/blood/robot
	blood_volume = 3000

	change_dir_on_move = FALSE

	movement_delay = DECISECONDS_TO_TICKS(6)

	soul_size = SOUL_SIZE_RARE

	object_size = 2

	respawn_time = SECONDS_TO_DECISECONDS(300)

	level = 70

/mob/living/simple/can_man/post_death()
	. = ..()
	charge_steps = 0
	charge_dir = 0
	icon_state = "dead"
	update_sprite()

/mob/living/simple/can_man/get_movement_delay(var/include_stance=TRUE)

	if(charge_steps > 0)
		return 1 //Max

	return ..()

/mob/living/simple/can_man/post_move(var/atom/old_loc)

	if(charge_steps > 0)
		play_sound('sound/effects/impacts/meteor_impact.ogg',get_turf(src))
		charge_steps -= 1

	. = ..()


/mob/living/simple/can_man/Bump(atom/Obstacle)

	if(Obstacle.health && charge_steps > 0)
		var/damagetype/DT = all_damage_types[/damagetype/npc/bubblegum]
		var/list/params = list()
		params[PARAM_ICON_X] = rand(0,32)
		params[PARAM_ICON_Y] = rand(0,32)
		var/atom/object_to_damage = Obstacle.get_object_to_damage(src,src,null,params,TRUE,TRUE)
		DT.process_damage(src,Obstacle,src,object_to_damage,src,1)


	return ..()


/mob/living/simple/can_man/proc/start_charge()

	if(CALLBACK_EXISTS("stop_charge_\ref[src]"))
		return FALSE


	charge_dir = dir
	charge_steps = rand(5,15)
	CALLBACK("stop_charge_\ref[src]",SECONDS_TO_DECISECONDS(2),src,.proc/finish_charge)
	return TRUE

/mob/living/simple/can_man/proc/finish_charge()
	charge_dir = 0
	charge_steps = 0
	CALLBACK_REMOVE("stop_charge_\ref[src]")
	return TRUE





