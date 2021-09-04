/mob/living/advanced/npc/skeleton_summon/
	name = "summoned skeleton"
	desc = "A skeleton summoned from a world of dark worshipping, here to aid you."
	species = "skeleton"
	sex = MALE
	gender = MALE
	var/desired_loadout = /loadout/skeleton_summon/summoned

	ai = /ai/advanced

	level = 1

/mob/living/advanced/npc/skeleton_summon/Initialize()
	. = ..()
	equip_loadout(desired_loadout)
