/mob/living/simple/can_man
	name = "Can Man"
	boss_icon_state = "can_man"
	icon = 'icons/mob/living/simple/canman.dmi'
	icon_state = "living"
	damage_type = /damagetype/unarmed/powerfist/can_man

	value = 20000

	ai = /ai/boss/can_man

	pixel_x = -8

	boss_loot = /loot/lavaland/can_man

	boss_music = /track/canman

	stun_angle = 0

	health_base = 11000
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
		DISARM = TRUE,
		FIRE = TRUE,
		GRAB = TRUE,
		PAINCRIT = TRUE
	)

	size = SIZE_BOSS

	enable_medical_hud = FALSE
	enable_security_hud = FALSE

	loyalty_tag = "Syndicate"
	iff_tag = "Syndicate"

	var/charge_steps = 0
	var/charge_dir = 0

	blood_type = /reagent/blood/robot
	blood_volume = 5000

	change_dir_on_move = FALSE

	movement_delay = DECISECONDS_TO_TICKS(4)

	soul_size = SOUL_SIZE_RARE

	object_size = 1

	respawn_time = SECONDS_TO_DECISECONDS(300)

	level = 90

	stun_angle = 0

	var/minigun_spread = 100 //Chance to hit an adjacent turf instead.

	var/minigun_delay = 0 //delay between each shot

/mob/living/simple/can_man/post_death()
	. = ..()
	charge_steps = 0
	charge_dir = 0x0
	update_sprite()

/mob/living/simple/can_man/update_icon()
	. = ..()
	icon = initial(icon)
	icon_state = initial(icon_state)
	if(dead)
		icon_state = "dead"

/mob/living/simple/can_man/is_busy()
	if(CALLBACK_EXISTS("\ref[src]_minigun_sweep"))
		return TRUE
	. = ..()

/mob/living/simple/can_man/proc/telegraph_special_minigun_sweep(var/atom/target)
	play_sound('sound/mob/can_man/rev_start.ogg',get_turf(src))
	CALLBACK("\ref[src]_minigun_sweep",10,src,src::do_special_minigun_sweep(),target,30,30)

/mob/living/simple/can_man/proc/do_special_minigun_sweep(var/atom/target,var/shots_current,var/shots_max)

	if(dead || horizontal)
		return FALSE

	shoot_minigun(target,TRUE)

	shots_current--

	if(shots_current <= 0)
		minigun_spread = initial(minigun_spread)
		if(ai) ai.find_new_objectives(bonus_sight=TRUE)
		add_status_effect(PARALYZE,duration=30,magnitude=-1,stealthy=TRUE)
		play_sound('sound/mob/can_man/rev_stop.ogg',get_turf(src))
		return TRUE

	CALLBACK("\ref[src]_minigun_sweep",0.25 + max(0,shots_current/shots_max - 0.5),src,src::do_special_minigun_sweep(),target,shots_current,shots_max)

/mob/living/simple/can_man/proc/shoot_minigun(var/atom/target,var/use_spread=FALSE)

	var/turf/T = get_turf(src)

	if(!T)
		return FALSE

	if(use_spread && prob(minigun_spread-50))
		var/found_direction = get_dir(src,target)
		var/offset_01 = turn(found_direction,90)
		var/offset_02 = turn(found_direction,-90)
		var/turf/new_target = get_step(target,pick(offset_01,offset_02))
		if(new_target)
			target = new_target

	src.shoot_projectile(
		src,
		target,
		null,
		null,
		/obj/projectile/bullet/firearm/pistol,
		/damagetype/ranged/bullet/pistol_45/hp,
		16,
		16,
		use_spread ? 0.1*(minigun_spread/100) : 0.03,
		TILE_SIZE*0.5,
		1,
		"#FF4A00",
		0,
		1,
		src.iff_tag,
		src.loyalty_tag
	)
	src.set_dir(get_dir(src,target))
	play_sound('sound/weapons/ranged/misc/canman_shot.ogg',T)

	if(use_spread)
		minigun_spread -= 5

	minigun_delay = world.time + 0.5 + (health.health_current/health.health_max)*1.5

/mob/living/simple/can_man/post_move(var/atom/old_loc)
	. = ..()
	//Crush below turf and the contents.
	if(!horizontal && ai && ai.objective_attack)
		var/turf/simulated/S = get_turf(src)
		if(is_simulated(S))
			play_sound('sound/effects/impacts/meteor_impact.ogg',S)
			var/damagetype/DT = all_damage_types[damage_type]
			var/list/params = list(
				PARAM_ICON_X = rand(0,32),
				PARAM_ICON_Y = rand(0,32),
				"left" = 0,
				"right" = 0,
				"middle" = 0,
				"ctrl" = 0,
				"shift" = 0,
				"alt" = 0
			)
			if(S.can_be_attacked(src,src,params,DT))
				var/atom/object_to_damage = S.get_object_to_damage(src,src,damage_type,params,TRUE,TRUE)
				DT.process_damage(src,S,src,object_to_damage,src,1)
			if(S.has_dense_atom)
				for(var/k in contents)
					var/atom/movable/M = k
					if(!M.density)
						continue
					if(M == src)
						continue
					if(!M.can_be_attacked(src,src,params,DT))
						continue
					var/atom/object_to_damage = M.get_object_to_damage(src,src,damage_type,params,TRUE,TRUE)
					DT.process_damage(src,M,src,object_to_damage,src,1)



