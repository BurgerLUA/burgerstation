/mob/living/simple/npc/ash_drake
	name = "ash drake"
	id = "ash_drake"
	icon = 'icons/mob/living/simple/lavaland/ashdrake.dmi'
	icon_state = "living"
	damage_type = "ash_drake_claw"
	class = "ash_drake"

	pixel_x = -16

	ai = /ai/boss/ash_drake/

	stun_angle = 0

	health_base = 2000

	var/boss_state = 0
	//0 = walking
	//1 = flying
	//2 = landing

	attack_range = 2

	force_spawn = TRUE
	boss = TRUE

/*
/mob/living/simple/npc/ash_drake/get_miss_chance(var/atom/attacker,var/atom/weapon,var/atom/target)

	if(boss_state)
		return 1000

	return ..()
*/

/mob/living/simple/npc/ash_drake/proc/fly()

	if(boss_state)
		return

	if(prob(1000))
		fire_rain()

	new/obj/effect/temp/ash_drake/swoop_up(src.loc)

	boss_state = 1
	collision_flags = FLAG_COLLISION_NONE
	collision_bullet_flags = FLAG_COLLISION_BULLET_NONE
	icon_state = "shadow"
	update_icon()

/mob/living/simple/npc/ash_drake/proc/land()

	if(boss_state != 1)
		return

	spawn()
		new/obj/effect/temp/ash_drake/swoop_down(src.loc)
		boss_state = 2
		sleep(SECONDS_TO_DECISECONDS(1))
		boss_state = 0
		icon_state = "living"
		collision_flags = initial(collision_flags)
		collision_bullet_flags = initial(collision_bullet_flags)
		update_icon()

		for(var/turf/T in range(2,src))
			new/obj/effect/temp/impact/combat/smash(T)

		for(var/mob/living/L in range(2,src))
			if(L == src)
				continue

			var/is_center = get_dist(src,L) == 0

			step(L,get_dir(src,L))
			L.add_stun(10 + is_center*30)
			//L.adjust_brute_loss(20 + is_center*20) HEALTH TODO

		if(prob(1000))
			fire_cross()


/mob/living/simple/npc/ash_drake/proc/fire_cross()

	var/starting_x = src.x
	var/starting_y = src.y

	spawn()
		for(var/i=1,i<=10,i++)
			var/turf/desired_turf1 = locate(starting_x+i,starting_y,1)
			var/turf/desired_turf2 = locate(starting_x-i,starting_y,1)
			var/turf/desired_turf3 = locate(starting_x,starting_y+i,1)
			var/turf/desired_turf4 = locate(starting_x,starting_y-i,1)
			new/obj/effect/temp/hazard/fire/(desired_turf1)
			new/obj/effect/temp/hazard/fire/(desired_turf2)
			new/obj/effect/temp/hazard/fire/(desired_turf3)
			new/obj/effect/temp/hazard/fire/(desired_turf4)
			sleep(1)


/mob/living/simple/npc/ash_drake/proc/fire_rain()

	if(!health)
		return FALSE

	var/list/turf/simulated/floor/valid_floors = list()

	for(var/turf/simulated/floor/T in range(4,src))
		valid_floors += T

	var/amount_multiplier = FLOOR(10 + (1 - (health.health_current/health.health_max))*20, 1)

	for(var/i=1,i<=amount_multiplier,i++)
		var/turf/T = pick(valid_floors)
		new/obj/effect/temp/ash_drake/target/(T)
		new/obj/effect/temp/hazard/falling_fireball(T,desired_owner = src)

	return TRUE

/mob/living/simple/npc/ash_drake/get_movement_delay()
	if(boss_state)
		return DECISECONDS_TO_TICKS(2)

	return ..()

/mob/living/simple/npc/ash_drake/proc/shoot_fireball(var/atom/desired_target)
	shoot_projectile(src,desired_target,null,null,/obj/projectile/bullet/fireball/,"ash_drake_fireball",16,16,0,20,1,"#FFFFFF",0,0)




/mob/living/simple/npc/ash_drake/post_death()
	..()
	icon_state = "dead"
	update_icon()







