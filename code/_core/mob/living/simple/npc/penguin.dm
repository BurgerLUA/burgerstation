/mob/living/simple/npc/passive/penguin
	name = "penguin"
	desc = "Business bird."
	desc_extended = "A harmless critter. Or so it may seem."
	icon = 'icons/mob/living/simple/passive.dmi'
	icon_state = "penguin"
	damage_type = /damagetype/unarmed/bite/
	class = /class/crab

	value = 50

	butcher_contents = list(
		/obj/item/container/food/dynamic/fish/penguin/,
		/obj/item/container/food/dynamic/fish/penguin/
	)

	mob_size = MOB_SIZE_ANIMAL

/mob/living/simple/npc/passive/penguin/post_death()
	..()
	icon_state = "[initial(icon_state)]_dead"
	update_sprite()