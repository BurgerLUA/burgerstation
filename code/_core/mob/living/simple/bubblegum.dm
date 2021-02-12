/mob/living/simple/bubblegum
	name = "bubblegum"
	boss_icon_state = "bubblegum"
	icon = 'icons/mob/living/simple/lavaland/bubblegum.dmi'
	icon_state = "living"
	damage_type = /damagetype/unarmed/claw/
	class = /class/bubblegum/
	ai = /ai/boss/bubblegum/

	boss_loot = /loot/lavaland/bubblegum

	pixel_x = -32

	value = 4000

	var/charge_steps = 0
	var/charge_dir = 0

	health_base = 12000
	stamina_base = 4000
	mana_base = 1000

	move_delay = BOSS_TICK*3

	stun_angle = 0

	attack_range = 2

	force_spawn = TRUE
	boss = TRUE

	armor_base = list(
		BLADE = AP_SWORD,
		BLUNT = AP_SWORD,
		LASER = AP_GREATSWORD,
		HEAT = AP_SWORD,
		COLD = AP_DAGGER,
		HOLY = -AP_SWORD,
		DARK = AP_CLUB,
		FATIGUE = AP_CLUB,
		ION = INFINITY,
		PAIN = INFINITY
	)

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
		/obj/item/container/food/dynamic/meat/raw_bubblegum,
		/obj/item/container/food/dynamic/meat/raw_bubblegum,
		/obj/item/container/food/dynamic/meat/raw_bubblegum,
		/obj/item/container/food/dynamic/meat/raw_bubblegum,
		/obj/item/container/food/dynamic/meat/raw_bubblegum,
		/obj/item/container/food/dynamic/meat/raw_bubblegum,
		/obj/item/container/food/dynamic/meat/raw_bubblegum,
		/obj/item/container/food/dynamic/meat/raw_bubblegum
	)

	iff_tag = "Bubblegum"
	loyalty_tag = "Bubblegum"

	fatigue_from_block_mul = 0

	size = SIZE_BOSS

	sprint_delay_mul = 1
	jog_delay_mul = 3
	walk_delay_mul = 4

	enable_medical_hud = FALSE
	enable_security_hud = FALSE

	blood_volume = 5000
	blood_type = /reagent/blood/ancient

	var/next_blood_attack = 0

/mob/living/simple/bubblegum/post_death()
	. = ..()
	charge_steps = 0
	charge_dir = 0
	icon_state = "dead"
	update_sprite()
	return .

/mob/living/simple/bubblegum/proc/blood_attack()

	if(next_blood_attack > world.time)
		return FALSE

	. = FALSE

	for(var/mob/living/A in view(VIEW_RANGE,src))
		if(A == src)
			continue
		if(A.dead)
			continue
		var/turf/simulated/T = get_turf(A)
		if(!istype(T))
			continue
		if(T.blood_level == 0)
			continue
		new/obj/effect/temp/hazard/bubblefist(T,null,src)
		. = TRUE

	next_blood_attack = world.time + SECONDS_TO_DECISECONDS(1)

	return .

/mob/living/simple/bubblegum/get_movement_delay()

	. = ..()

	if(charge_steps)
		. = BOSS_TICK*1

	return .

/mob/living/simple/bubblegum/post_move(var/atom/old_loc)

	play_sound('sound/effects/impacts/meteor_impact.ogg',get_turf(src),volume = charge_steps ? 50 : 25)

	if(charge_steps)
		var/turf/simulated/T0 = get_turf(src)
		var/turf/simulated/T1 = get_step(src,turn(dir,90))
		var/turf/simulated/T2 = get_step(src,turn(dir,-90))
		create_blood(/obj/effect/cleanable/blood/splatter,T0,"#7F0000",rand(-8,8),rand(-8,8))
		create_blood(/obj/effect/cleanable/blood/splatter,T1,"#7F0000",rand(-8,8),rand(-8,8))
		create_blood(/obj/effect/cleanable/blood/splatter,T2,"#7F0000",rand(-8,8),rand(-8,8))

	return ..()

/mob/living/simple/bubblegum/Bump(atom/Obstacle)

	if(Obstacle.health)
		var/damagetype/DT = all_damage_types[/damagetype/npc/bubblegum]
		var/list/params = list()
		params[PARAM_ICON_X] = rand(0,32)
		params[PARAM_ICON_Y] = rand(0,32)
		var/atom/object_to_damage = Obstacle.get_object_to_damage(src,src,params,TRUE,TRUE)
		visible_message(span("danger","\The [src.name] rams into \the [Obstacle.name]!"))
		DT.hit(src,Obstacle,src,object_to_damage,src,1)

	return ..()

/mob/living/simple/bubblegum/proc/start_charge()
	charge_dir = dir
	charge_steps = 9
	CALLBACK("stop_charge_\ref[src]",SECONDS_TO_DECISECONDS(4),src,.proc/finish_charge) //Fallback time.
	return TRUE

/mob/living/simple/bubblegum/proc/finish_charge()
	charge_dir = 0
	charge_steps = 0
	CALLBACK_REMOVE("stop_charge_\ref[src]")
	return TRUE