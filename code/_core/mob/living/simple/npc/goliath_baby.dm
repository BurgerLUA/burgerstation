/mob/living/simple/npc/goliath/baby
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

	armor_base = list(
		BLADE = 75,
		BLUNT = 75,
		PIERCE = 75,
		LASER = -25,
		MAGIC = -25,
		HEAT = INFINITY,
		COLD = -25,
		BOMB = INFINITY,
		BIO = 75,
		RAD = 75,
		HOLY = -25,
		DARK = INFINITY,
		FATIGUE = INFINITY
	)

	mob_size = MOB_SIZE_CRITTER


/mob/living/simple/npc/goliath/baby/post_death()
	. = ..()
	explode(get_turf(src),2,src,src,loyalty_tag)
	return .