/mob/living/simple/npc/cult/cultist
	name = "cultist of Nar'sie"
	icon = 'icons/mob/living/simple/cult.dmi'
	icon_state = "cultist"

	damage_type = "cultist"

	ai = /ai/simple/cultist

	loot_drop = "cult"

	stun_angle = 90

	damage_type = "sword_claymore_cult"

/mob/living/simple/npc/cult/cultist/post_death()
	..()
	icon_state = "[initial(icon_state)]_dead"
	update_icon()

/mob/living/simple/npc/cult/behemoth
	name = "behemoth"
	icon = 'icons/mob/living/simple/cult.dmi'
	icon_state = "behemoth"

	damage_type = "behemoth"

	ai = /ai/simple/behemoth

	loot_drop = "cult"


/mob/living/simple/npc/cult/artificer
	name = "artificer"
	icon = 'icons/mob/living/simple/cult.dmi'
	icon_state = "artificer"

	damage_type = null

	ai = /ai/simple/artificer

	loot_drop = "cult"


/mob/living/simple/npc/cult/harvester
	name = "harvester"
	icon = 'icons/mob/living/simple/cult.dmi'
	icon_state = "harvester"

	damage_type = "harvester"

	ai = /ai/simple/harvester

	loot_drop = "cult"