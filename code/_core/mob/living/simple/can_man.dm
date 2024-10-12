/mob/living/simple/can_man

	name = "Can Man"
	desc = "The man with the can."


	icon = 'icons/mob/living/simple/canman.dmi'
	icon_state = "living"
	boss_icon_state = "can_man"
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
	respawn_time = SECONDS_TO_DECISECONDS(300)

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

	blood_type = /reagent/blood/robot
	blood_volume = 5000

	change_dir_on_move = FALSE

	movement_delay = DECISECONDS_TO_TICKS(10)

	soul_size = SOUL_SIZE_RARE

	object_size = 1

	level = 90

	use_momentum = FALSE

/mob/living/simple/can_man/proc/shoot_minigun(var/atom/target)

	var/turf/T

	var/target_dir = get_dir(src,target)

	if(src.dir & target_dir) //Facing.
		T = get_turf(target)
	else //Not facing.
		var/desired_dir = turn(dir,pick(-45,0,45))
		T = get_step(src,desired_dir)

	if(!T)
		return FALSE

	src.shoot_projectile(
		src,
		T,
		null,
		null,
		/obj/projectile/bullet/firearm/pistol,
		/damagetype/ranged/bullet/pistol_45/hp,
		16,
		16,
		0.01,
		TILE_SIZE*0.5,
		1,
		"#FF4A00",
		0,
		1,
		src.iff_tag,
		src.loyalty_tag
	)

	play_sound('sound/weapons/ranged/misc/canman_shot.ogg',T)

/mob/living/simple/can_man/post_move(var/atom/old_loc)
	. = ..()
	//Crush below turf and the contents.
	if(!horizontal && ai && ai.objective_attack)
		var/turf/simulated/S = get_turf(src)
		if(is_simulated(S))
			play_sound('sound/effects/impacts/meteor_impact.ogg',S)
			var/damagetype/DT = SSdamagetype.all_damage_types[damage_type]
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