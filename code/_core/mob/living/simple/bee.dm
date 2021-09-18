/mob/living/simple/bee
	name = "Bee"
	desc = "Whats the Buzz?"
	desc_extended = "Dont let it sting you"
	icon = 'icons/mob/living/simple/bee.dmi'
	icon_state = "drone"
	damage_type = /damagetype/unarmed/claw

	level = 2

/mob/living/simple/bee/post_death()
	qdel(src)
	return ..()
