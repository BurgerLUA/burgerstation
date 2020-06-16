/mob/living/simple/npc/passive/cow
	name = "cow"
	icon_state = "cow"
	damage_type = /damagetype/npc/cow
	class = /class/cow
	butcher_contents = list(
		/obj/item/container/food/dynamic/meat/raw,
		/obj/item/container/food/dynamic/meat/raw,
		/obj/item/container/food/dynamic/meat/raw,
		/obj/item/container/food/dynamic/meat/raw
	)

	mob_size = MOB_SIZE_HUMAN

/mob/living/simple/npc/passive/cow/post_death()
	..()
	icon_state = "[initial(icon_state)]_dead"
	update_sprite()