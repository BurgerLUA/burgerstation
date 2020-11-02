/mob/living/simple/npc/goliath
	name = "goliath"
	icon = 'icons/mob/living/simple/lavaland/goliath.dmi'
	icon_state = "goliath"
	damage_type = /damagetype/unarmed/claw/
	class = /class/goliath

	value = 25

	ai = /ai/goliath

	health_base = 200

	stun_angle = 0

	armor_base = list(
		BLADE = 25,
		BLUNT = 50,
		PIERCE = 75,
		LASER = 50,
		ARCANE = 25,
		HEAT = 100,
		COLD = -25,
		BOMB = 50,
		BIO = 50,
		RAD = 50,
		HOLY = 50,
		DARK = 100,
		FATIGUE = 25,
		ION = INFINITY
	)

	status_immune = list(
		FIRE = TRUE
	)

	iff_tag = "Goliath"
	loyalty_tag = "Goliath"

	mob_size = MOB_SIZE_LARGE

/mob/living/simple/npc/goliath/post_death()
	..()
	icon_state = "[initial(icon_state)]_dead"
	update_sprite()

/mob/living/simple/npc/goliath/proc/try_tentacle_attack(var/mob/living/desired_target)

	if(dead)
		return FALSE

	if(get_dist(src,desired_target) > VIEW_RANGE)
		return FALSE

	add_status_effect(PARALYZE,20,20,stealthy = TRUE)
	icon_state = "[initial(icon_state)]_attack"

	CALLBACK("\ref[src]_tentacle_attack",10,src,.proc/do_tentacle_attack,desired_target)

	return TRUE


/mob/living/simple/npc/goliath/proc/do_tentacle_attack(var/mob/living/desired_target)

	if(dead)
		return FALSE

	if(get_dist(src,desired_target) <= VIEW_RANGE)
		var/list/valid_turfs = list()
		valid_turfs += get_step(desired_target,NORTH)
		valid_turfs += get_step(desired_target,EAST)
		valid_turfs += get_step(desired_target,SOUTH)
		valid_turfs += get_step(desired_target,WEST)
		valid_turfs -= pick(valid_turfs)
		valid_turfs += get_turf(desired_target)
		for(var/k in valid_turfs)
			var/turf/T = k
			new/obj/effect/temp/hazard/tentacle/(T,desired_owner = src)

	icon_state = initial(icon_state)