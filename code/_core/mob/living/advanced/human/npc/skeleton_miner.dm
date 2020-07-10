/mob/living/advanced/npc/skeleton_miner
	name = "skeleton miner minion"
	desc = "Worked to the bone."
	desc_extended = "A reanimated magical skeleton forced to work the phoron mines of the Syndicate for all eternity."

	species = "skeleton"
	sex = MALE
	gender = MALE
	var/desired_loadout = /loadout/skeleton_miner/skeleton
	class = /class/pirate

	loyalty_tag = "Syndicate"
	iff_tag = "Syndicate"
	ai = /ai/advanced/skeleton


/mob/living/advanced/npc/skeleton_miner/Initialize()
	. = ..()
	equip_loadout(desired_loadout)
	return .

/mob/living/advanced/npc/skeleton_miner/shovel
	desired_loadout = /loadout/skeleton_miner/skeleton/shovel

/mob/living/advanced/npc/skeleton_miner/pickaxe
	desired_loadout = /loadout/skeleton_miner/skeleton/pickaxe

/mob/living/advanced/npc/skeleton_miner/torch
	desired_loadout = /loadout/skeleton_miner/skeleton/torch
