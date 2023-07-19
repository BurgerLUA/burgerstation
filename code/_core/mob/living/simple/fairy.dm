/mob/living/simple/fairy
	name = "fairy"
	desc = "Hey, listen!"
	desc_extended = "If you have to listen to this damned thing for one more second you're going to take your eardrums out... how you'll do that is beyond you."
	icon = 'icons/mob/living/simple/fairy.dmi'
	icon_state = "living"

	damage_type = /damagetype/npc/fairy

	ai = /ai/

	health_base = 2500
	stamina_base = 5000
	mana_base = 50

	value = 1000

	size = SIZE_ANIMAL

	movement_delay = DECISECONDS_TO_TICKS(1)

	loyalty_tag = "Meme"
	iff_tag = "Meme"

	blood_type = /reagent/medicine/mana_potion

	soul_size = SOUL_SIZE_RARE

	level = 16

/mob/living/simple/fairy/post_death()
	..()
	icon_state = "dead"
	var/turf/T = get_turf(src)
	CREATE(/obj/item/clothing/back/wings/fairy,T)