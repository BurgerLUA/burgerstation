/mob/living/simple/npc/passive/cow
	name = "cow"
	icon_state = "cow"

/mob/living/simple/npc/passive/cow/post_death()
	..()
	icon_state = "[initial(icon_state)]_dead"
	update_icon()