/mob/living/simple/npc/glockroach
	name = "glockroach"
	desc = "!"
	desc_extended = "A harmless critter. Or so it may seem."
	icon = 'icons/mob/living/simple/glockroach.dmi'
	icon_state = "glockroach"
	damage_type = /damagetype/ranged/bullet/pistol_10mm
	class = /class/glockroach

	value = 25

	ai = /ai/simple/glockroach

	stun_angle = 180

	armor_base = list(
		BLADE = 25,
		BLUNT = -50,
		PIERCE = 25,
		LASER = 25,
		ARCANE = 50,
		HEAT = 25,
		COLD = -50,
		BOMB = 25,
		BIO = 50,
		HOLY = 100,
		DARK = 100,
		ION = INFINITY
	)

	mob_size = MOB_SIZE_ANIMAL

	movement_delay = DECISECONDS_TO_TICKS(2)

/mob/living/simple/npc/glockroach/post_death()
	..()
	icon_state = "[initial(icon_state)]_dead"
	update_sprite()

