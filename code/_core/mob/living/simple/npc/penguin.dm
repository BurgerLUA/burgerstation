/mob/living/simple/npc/penguin
	name = "penguin"
	icon = 'icons/mob/living/simple/passive.dmi'
	icon_state = "penguin"
	damage_type = /damagetype/unarmed/bite/
	class = "crab"

	ai = /ai/

	armor_base = list(
		BLADE = 0,
		BLUNT = 0,
		PIERCE = 0,
		LASER = -ARMOR_D,
		MAGIC = 0,
		HEAT = -ARMOR_C,
		COLD = ARMOR_B,
		BOMB = 0,
		BIO = 0,
		RAD = 0,
		HOLY = 0,
		DARK = 0,
		FATIGUE = ARMOR_C
	)

/mob/living/simple/npc/penguin/post_death()
	..()
	icon_state = "[initial(icon_state)]_dead"
	update_sprite()