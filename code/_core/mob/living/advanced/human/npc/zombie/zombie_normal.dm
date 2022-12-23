/mob/living/advanced/npc/zombie/normal
	loadout = /loadout/zombie/civilian

/mob/living/advanced/npc/zombie/normal/Initialize()
	. = ..()
	if(gender == FEMALE)
		loadout = /loadout/zombie/civilian/female
	else
		loadout = /loadout/zombie/civilian/male
