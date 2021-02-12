/mob/living/simple/ash_drake
	name = "ash drake"
	boss_icon_state = "ash_drake"
	icon = 'icons/mob/living/simple/lavaland/ashdrake.dmi'
	icon_state = "living"
	damage_type = /damagetype/unarmed/claw/
	class = /class/ash_drake

	value = 6000

	pixel_w = -16

	ai = /ai/boss/ash_drake/

	butcher_contents = list(
		/obj/item/container/food/dynamic/meat/raw_ash_drake,
		/obj/item/container/food/dynamic/meat/raw_ash_drake,
		/obj/item/container/food/dynamic/meat/raw_ash_drake,
		/obj/item/container/food/dynamic/meat/raw_ash_drake,
		/obj/item/container/food/dynamic/meat/raw_ash_drake,
		/obj/item/container/food/dynamic/meat/raw_ash_drake
	)

	stun_angle = 0

	health_base = 10000
	stamina_base = 500
	mana_base = 2000

	boss_loot = /loot/lavaland/ash_drake

	var/boss_state = 0
	//0 = walking
	//1 = flying
	//2 = landing

	attack_range = 2

	force_spawn = TRUE
	boss = TRUE

	armor_base = list(
		BLADE = AP_SWORD,
		BLUNT = AP_SWORD,
		PIERCE = AP_AXE,
		LASER = AP_GREATSWORD,
		ARCANE = AP_SWORD,
		HEAT = AP_GREATSWORD,
		COLD = -AP_AXE,
		BIO = AP_SWORD,
		RAD = AP_GREATSWORD,
		HOLY = -AP_SWORD,
		DARK = AP_GREATSWORD,
		FATIGUE = AP_SWORD,
		ION = INFINITY,
		PAIN = AP_SWORD
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

	iff_tag = "Ash Drake"
	loyalty_tag = "Ash Drake"

	blood_type = /reagent/blood/ancient
	blood_volume = 3000


/*
/mob/living/simple/ash_drake/get_miss_chance(var/atom/attacker,var/atom/weapon,var/atom/target)

	if(boss_state)
		return 1000

	return ..()
*/

/mob/living/simple/ash_drake/proc/fly()

	if(boss_state)
		return

	if(prob(50))
		fire_rain()

	new/obj/effect/temp/ash_drake/swoop_up(src.loc)

	boss_state = 1
	update_collisions(FLAG_COLLISION_NONE,FLAG_COLLISION_BULLET_NONE)
	interaction_flags = 0x0
	icon_state = "shadow"
	update_sprite()

/mob/living/simple/ash_drake/proc/land()

	if(boss_state != 1)
		return

	new/obj/effect/temp/ash_drake/swoop_down(src.loc)
	boss_state = 2

	spawn(SECONDS_TO_DECISECONDS(1))
		boss_state = 0
		icon_state = "living"
		update_collisions(initial(collision_flags),initial(collision_bullet_flags))
		interaction_flags = initial(interaction_flags)
		update_sprite()

		for(var/turf/T in range(2,src))
			new/obj/effect/temp/impact/combat/smash(T)

		for(var/mob/living/L in range(2,src))
			if(L == src)
				continue

			var/is_center = get_dist(src,L) == 0

			step(L,get_dir(src,L))
			L.add_status_effect(STAGGER,10 + is_center*30,10 + is_center*30,source = src)

		fire_cross()


/mob/living/simple/ash_drake/proc/fire_cross()

	var/turf/T = get_turf(src)
	var/starting_x = T.x
	var/starting_y = T.y
	var/starting_z = T.z

	spawn()
		for(var/i=1,i<=10,i++)
			var/turf/desired_turf1 = locate(starting_x+i,starting_y,starting_z)
			var/turf/desired_turf2 = locate(starting_x-i,starting_y,starting_z)
			var/turf/desired_turf3 = locate(starting_x,starting_y+i,starting_z)
			var/turf/desired_turf4 = locate(starting_x,starting_y-i,starting_z)
			new/obj/effect/temp/hazard/fire/(desired_turf1)
			new/obj/effect/temp/hazard/fire/(desired_turf2)
			new/obj/effect/temp/hazard/fire/(desired_turf3)
			new/obj/effect/temp/hazard/fire/(desired_turf4)
			sleep(1)


/mob/living/simple/ash_drake/proc/fire_rain()

	if(!health)
		return FALSE

	var/list/turf/simulated/floor/valid_floors = list()

	for(var/turf/simulated/floor/T in range(4,src))
		valid_floors += T

	var/amount_multiplier = FLOOR(10 + (1 - (health.health_current/health.health_max))*20, 1)

	for(var/i=1,i<=amount_multiplier,i++)
		var/turf/T = pick(valid_floors)
		new/obj/effect/temp/ash_drake/target/(T)
		new/obj/effect/falling_fireball(T)

	return TRUE

/mob/living/simple/ash_drake/get_movement_delay()

	. = ..()

	if(boss_state)
		. *= 0.5

	return .

/mob/living/simple/ash_drake/proc/shoot_fireball(var/atom/desired_target)
	shoot_projectile(src,desired_target,null,null,/obj/projectile/magic/fireball/lava,/damagetype/ranged/magic/fireball,16,16,0,TILE_SIZE*0.75,1,"#FFFFFF",0,0,1,iff_tag,loyalty_tag)

/mob/living/simple/ash_drake/post_death()
	..()
	icon_state = "dead"
	update_sprite()







