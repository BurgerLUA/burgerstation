/mob/living/simple/npc/bull

	name = "angry bull"
	desc = "Protector of cows."
	desc_extended = "Can be seen protecting grasslands from pesky humanoids."
	icon = 'icons/mob/living/simple/passive.dmi'
	icon_state = "bull"

	health_base = 100

	ai = /ai/
	class = "bull"
	damage_type = "bull_gore"

/mob/living/simple/npc/bull/post_death()
	..()
	icon_state = "[initial(icon_state)]_dead"
	update_icon()