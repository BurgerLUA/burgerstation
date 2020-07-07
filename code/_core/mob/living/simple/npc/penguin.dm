/mob/living/simple/npc/passive/penguin
	name = "penguin"
	desc = "Business bird."
	desc_extended = "A harmless critter. Or so it may seem."
	icon = 'icons/mob/living/simple/passive.dmi'
	icon_state = "penguin"
	damage_type = /damagetype/unarmed/bite/
	class = /class/crab

	value = 50

	armor_base = list(
		BLADE = 0,
		BLUNT = 0,
		PIERCE = 0,
		LASER = -15,
		MAGIC = 0,
		HEAT = -25,
		COLD = 50,
		BOMB = 0,
		BIO = 0,
		RAD = 0,
		HOLY = 0,
		DARK = 0,
		FATIGUE = 25
	)

	butcher_contents = list(
		/obj/item/container/food/dynamic/fish/penguin/,
		/obj/item/container/food/dynamic/fish/penguin/
	)

	mob_size = MOB_SIZE_ANIMAL

/mob/living/simple/npc/passive/penguin/post_death()
	..()
	icon_state = "[initial(icon_state)]_dead"
	update_sprite()