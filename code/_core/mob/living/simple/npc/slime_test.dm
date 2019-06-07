/mob/living/simple/npc/slime_test
	name = "slime"
	desc = "Oh no. They're here too!"

	icon = 'icons/mob/living/simple/slimes_new.dmi'
	icon_state = "small_neutral"

	var/stored_slimes = 1

	ai = /ai/bear/

	can_attack_while_moving = FALSE

	var/happiness_mod = 0
	var/anger_mod = 0
	var/sadness_mod = 0

	color = "#FF0000"
	alpha = 150
