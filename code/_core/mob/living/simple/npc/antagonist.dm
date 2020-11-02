/mob/living/simple/npc/antag
	name = "crewmember"
	desc = "Uh..."
	desc_extended = "What the fuck?"
	icon = 'icons/mob/living/simple/antag.dmi'
	icon_state = "living"

	health_base = 200

	ai = /ai/traitor
	class = /class/player
	damage_type = /damagetype/npc/antag

	iff_tag = "NanoTrasen"
	loyalty_tag = "NanoTrasen"

	mob_size = MOB_SIZE_BOSS

	armor_base = list(
		BLADE = 0,
		BLUNT = 0,
		PIERCE = 0,
		LASER = 0,
		ARCANE = 0,
		HEAT = 0,
		COLD = 0,
		BOMB = 0,
		BIO = 0,
		RAD = 0,
		HOLY = 0,
		DARK = 0,
		FATIGUE = 0,
		ION = INFINITY
	)

	attack_range = 3

	movement_delay = DECISECONDS_TO_TICKS(1.5)

	stun_angle = 0

/mob/living/simple/npc/antag/Initialize()
	var/image/I = new/image(icon,"shadow")
	I.blend_mode = BLEND_MULTIPLY
	add_underlay(I)
	return ..()


/mob/living/simple/npc/antag/post_death()
	icon_state = "dead"
	return ..()