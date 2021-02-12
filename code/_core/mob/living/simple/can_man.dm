/mob/living/simple/can_man
	name = "Can Man"
	boss_icon_state = "can_man"
	icon = 'icons/mob/living/simple/canman.dmi'
	icon_state = "living"
	damage_type = /damagetype/unarmed/claw/
	class = /class/ash_drake

	value = 20000

	pixel_w = -8

	ai = /ai/boss/can_man

	boss_loot = /loot/lavaland/can_man

	stun_angle = 0

	health_base = 10000
	stamina_base = 4000
	mana_base = 100

	attack_range = 2

	force_spawn = TRUE
	boss = TRUE

	armor_base = list(
		BLADE = AP_CLUB,
		BLUNT = AP_SWORD,
		PIERCE = AP_SWORD,
		LASER = AP_CLUB,
		ARCANE = -AP_SWORD,
		HEAT = AP_GREATSWORD,
		COLD = AP_GREATSWORD,
		BIO = INFINITY,
		RAD = INFINITY,
		HOLY = INFINITY,
		DARK = INFINITY,
		FATIGUE = INFINITY,
		PAIN = INFINITY
	)

	fatigue_from_block_mul = 0

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

/mob/living/simple/can_man/post_death()
	. = ..()
	charge_steps = 0
	charge_dir = 0
	icon_state = "dead"
	update_sprite()

/mob/living/simple/can_man/get_movement_delay()

	if(charge_steps)
		return 1 //Max

	return ..()

/mob/living/simple/can_man/post_move(var/atom/old_loc)

	if(charge_steps)
		play_sound('sound/effects/impacts/meteor_impact.ogg',get_turf(src))

	return ..()


/mob/living/simple/can_man/Bump(atom/Obstacle)

	if(charge_steps && Obstacle.health)
		var/damagetype/DT = all_damage_types[/damagetype/npc/bubblegum]
		var/list/params = list()
		params[PARAM_ICON_X] = rand(0,32)
		params[PARAM_ICON_Y] = rand(0,32)
		var/atom/object_to_damage = Obstacle.get_object_to_damage(src,src,params,TRUE,TRUE)
		DT.hit(src,Obstacle,src,object_to_damage,src,1)

	return ..()


/mob/living/simple/can_man/proc/start_charge()
	charge_dir = dir
	charge_steps = rand(5,15)
	CALLBACK("stop_charge_\ref[src]",SECONDS_TO_DECISECONDS(2),src,.proc/finish_charge)
	return TRUE

/mob/living/simple/can_man/proc/finish_charge()
	charge_dir = 0
	charge_steps = 0
	CALLBACK_REMOVE("stop_charge_\ref[src]")
	return TRUE





