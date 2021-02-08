/mob/living/simple/goliath/baby
	name = "baby goliath"
	desc = "More of a boomer than a millenial."
	icon = 'icons/mob/living/simple/lavaland/goliath_baby.dmi'
	icon_state = "baby"
	damage_type = /damagetype/unarmed/claw/
	class = /class/goliath/baby/

	ai = /ai/

	stun_angle = 0

	health_base = 50

	attack_range = 1

	size = SIZE_CRITTER

/mob/living/simple/goliath/baby/post_death()
	. = ..()
	explode(get_turf(src),2,src,src,loyalty_tag)
	qdel(src)
	return .