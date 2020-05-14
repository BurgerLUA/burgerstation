/mob/living/simple/npc/bull

	name = "angry bull"
	desc = "Protector of cows."
	desc_extended = "Can be seen protecting grasslands from pesky humanoids."
	icon = 'icons/mob/living/simple/passive.dmi'
	icon_state = "bull"

	health_base = 100

	ai = /ai/
	class = "bull"
	damage_type = /damagetype/npc/bull

	armor_base = list(
		BLADE = 25,
		BLUNT = 25,
		PIERCE = 25,
		LASER = -25,
		MAGIC = -25,
		HEAT = 0,
		COLD = 0,
		BOMB = 0,
		BIO = 0,
		RAD = 0,
		HOLY = 50,
		DARK = 100,
		FATIGUE = 0
	)

/mob/living/simple/npc/bull/post_death()
	..()
	icon_state = "[initial(icon_state)]_dead"
	update_sprite()