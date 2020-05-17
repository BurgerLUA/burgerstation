/mob/living/simple/npc/arachnid
	name = "giant arachnid"
	icon = 'icons/mob/living/simple/jungle/arachnid.dmi'
	icon_state = "living"
	damage_type = /damagetype/unarmed/claw/
	class = "arachnid"

	ai = /ai/

	stun_angle = 0

	pixel_x = -16

	armor_base = list(
		BLADE = 50,
		BLUNT = 25,
		PIERCE = 75,
		LASER = -25,
		MAGIC = 25,
		HEAT = 50,
		COLD = -50,
		BOMB = 25,
		BIO = INFINITY,
		RAD = INFINITY,
		HOLY = 100,
		DARK = 100,
		FATIGUE = 25
	)

	iff_tag = "jungle"
	loyalty_tag = "jungle"

	health_base = 500

	movement_delay = DECISECONDS_TO_TICKS(1)

/mob/living/simple/npc/arachnid/post_death()
	. = ..()
	icon_state = "dead"
	update_sprite()