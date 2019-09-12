/mob/living/simple/npc/goliath
	name = "goliath"
	icon = 'icons/mob/living/simple/goliath.dmi'
	icon_state = "goliath"
	damage_type = "goliath_claw"
	class = "goliath"

	ai = /ai/simple/goliath

	stun_angle = 0

	loot_drop = "goliath"

/mob/living/simple/npc/goliath/post_death()
	..()
	icon_state = "[initial(icon_state)]_dead"
	update_icon()

/mob/living/simple/npc/goliath/proc/tentacle_attack(var/mob/living/desired_target)

	spawn()
		add_stun(20)
		icon_state = "goliath_attack"
		sleep(10)
		var/list/valid_turfs = list()
		valid_turfs += get_step(desired_target,NORTH)
		valid_turfs += get_step(desired_target,EAST)
		valid_turfs += get_step(desired_target,SOUTH)
		valid_turfs += get_step(desired_target,WEST)
		valid_turfs -= pick(valid_turfs)

		for(var/turf/T in valid_turfs)
			new/obj/effect/temp/hazard/tentacle/(T,desired_owner = src)

		new/obj/effect/temp/hazard/tentacle/(get_turf(desired_target),desired_owner = src)
		sleep(10)
		icon_state = initial(icon_state)

