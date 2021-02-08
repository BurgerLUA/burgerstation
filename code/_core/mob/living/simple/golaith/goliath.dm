/mob/living/simple/goliath
	name = "goliath"
	icon = 'icons/mob/living/simple/lavaland/goliath.dmi'
	icon_state = "goliath"
	damage_type = /damagetype/unarmed/claw/
	class = /class/goliath

	butcher_contents = list(
		/obj/item/container/food/dynamic/meat/raw_goliath,
		/obj/item/container/food/dynamic/meat/raw_goliath,
		/obj/item/container/food/dynamic/meat/raw_goliath
	)

	value = 25

	ai = /ai/goliath

	health_base = 200
	stamina_base = 100
	mana_base = 200

	stun_angle = 0

	armor_base = list(
		BLADE = AP_SWORD,
		BLUNT = AP_AXE,
		LASER = AP_CLUB,
		HEAT = AP_GREATSWORD,
		COLD = -AP_SWORD,
		BOMB = AP_GREATSWORD,
		BIO = AP_SWORD,
		HOLY = -AP_SWORD,
		DARK = AP_GREATAXE,
		FATIGUE = AP_SWORD,
		ION = INFINITY,
		PAIN = AP_SWORD
	)

	status_immune = list(
		FIRE = TRUE
	)

	iff_tag = "Goliath"
	loyalty_tag = "Goliath"

	size = SIZE_LARGE

	blood_type = /reagent/blood/goliath
	blood_volume = 750

/mob/living/simple/goliath/post_death()
	..()
	icon_state = "[initial(icon_state)]_dead"
	update_sprite()

/mob/living/simple/goliath/proc/try_tentacle_attack(var/mob/living/desired_target)

	if(dead)
		return FALSE

	if(get_dist(src,desired_target) > VIEW_RANGE)
		return FALSE

	add_status_effect(PARALYZE,20,20,stealthy = TRUE)
	icon_state = "[initial(icon_state)]_attack"

	CALLBACK("\ref[src]_tentacle_attack",10,src,.proc/do_tentacle_attack,desired_target)

	return TRUE


/mob/living/simple/goliath/proc/do_tentacle_attack(var/mob/living/desired_target)

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