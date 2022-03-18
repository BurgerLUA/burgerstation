/mob/living/simple/goliath
	name = "goliath"
	icon = 'icons/mob/living/simple/lavaland/goliath.dmi'
	icon_state = "goliath"
	damage_type = /damagetype/unarmed/claw/


	butcher_contents = list(
		/obj/item/container/edible/dynamic/meat/raw_goliath,
		/obj/item/container/edible/dynamic/meat/raw_goliath,
		/obj/item/container/edible/dynamic/meat/raw_goliath
	)

	value = 25

	ai = /ai/goliath

	health_base = 200
	stamina_base = 100
	mana_base = 200

	stun_angle = 0

	armor = /armor/goliath

	status_immune = list(
		FIRE = TRUE
	)

	iff_tag = "Goliath"
	loyalty_tag = "Goliath"

	size = SIZE_LARGE

	blood_type = /reagent/blood/goliath
	blood_volume = 750

	soul_size = SOUL_SIZE_COMMON

	level = 24

	movement_delay = DECISECONDS_TO_TICKS(2)

/mob/living/simple/goliath/post_death()
	..()
	icon_state = "[initial(icon_state)]_dead"
	update_sprite()

/mob/living/simple/goliath/proc/try_tentacle_attack(var/mob/living/desired_target)

	if(dead)
		return FALSE

	if(src.z != desired_target.z || get_dist(src,desired_target) > VIEW_RANGE)
		return FALSE

	add_status_effect(PARALYZE,50,50,stealthy = TRUE)
	icon_state = "[initial(icon_state)]_attack"

	CALLBACK("\ref[src]_tentacle_attack",30,src,.proc/do_tentacle_attack,desired_target)

	return TRUE


/mob/living/simple/goliath/proc/do_tentacle_attack(var/mob/living/desired_target)

	if(dead)
		return FALSE

	if(get_dist(src,desired_target) <= VIEW_RANGE && src.z == desired_target.z)
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