/mob/living/advanced/npc/skeleton_miner
	name = "skeleton mind-slave"
	desc = "A mind-slaved skeleton worked to the bone at a syndicate mining facility."
	species = "skeleton"
	sex = MALE
	gender = MALE
	var/desired_loadout = /loadout/skeleton_miner/skeleton
	class = /class/pirate

	loyalty_tag = "Skeleton"
	iff_tag = "Skeleton"
	ai = /ai/advanced/skeleton


/mob/living/advanced/npc/skeleton_miner/Initialize()
	. = ..()
	equip_loadout(desired_loadout)
	return .

/mob/living/advanced/npc/skeleton_miner/shovel
	name = "skeleton mind-slave"
	desired_loadout = /loadout/skeleton_miner/skeleton/shovel

/mob/living/advanced/npc/skeleton_miner/pickaxe
	name = "skeleton mind-slave"
	desired_loadout = /loadout/skeleton_miner/skeleton/pickaxe

/mob/living/advanced/npc/skeleton_miner/torch
	name = "skeleton mind-slave"
	desired_loadout = /loadout/skeleton_miner/skeleton/torch
