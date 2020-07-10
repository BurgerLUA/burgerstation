/mob/living/simple/npc/bull

	name = "angry bull"
	desc = "Protector of cows."
	desc_extended = "Can be seen protecting grasslands from pesky humanoids."
	icon = 'icons/mob/living/simple/passive.dmi'
	icon_state = "bull"

	health_base = 100

	value = 50

	butcher_contents = list(
		/obj/item/container/food/dynamic/meat/raw,
		/obj/item/container/food/dynamic/meat/raw,
		/obj/item/container/food/dynamic/meat/raw,
		/obj/item/container/food/dynamic/meat/raw
	)


	ai = /ai/
	class = /class/bull
	damage_type = /damagetype/npc/bull

	armor_base = list(
		BLADE = 25,
		BLUNT = 25,
		PIERCE = 25,
		LASER = -25,
		MAGIC = 25,
		HOLY = 50,
		DARK = 100
	)

	mob_size = MOB_SIZE_LARGE

/mob/living/simple/npc/bull/post_death()
	..()
	icon_state = "[initial(icon_state)]_dead"
	update_sprite()