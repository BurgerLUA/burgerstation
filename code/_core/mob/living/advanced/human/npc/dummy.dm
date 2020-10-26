/mob/living/advanced/npc/dummy
	name = "target practice dummy"
	desc = "It's a dummy, dummy."
	desc_extended = "A standard NanoTrasen practice dummy used to train new recruits how to shoot, and more importantly, how to aim."
	ai = null
	class = /class/dummy
	species = "dummy"

	immortal = TRUE

	blood_type = null

	anchored = TRUE

/mob/living/advanced/npc/dummy/get_xp_multiplier()
	return 0.1

/mob/living/advanced/npc/dummy/Initialize()
	. = ..()
	change_organ_visual("skin", desired_color = "#C0C0C0")
	change_organ_visual("hair_head", desired_color = "#EFC700", desired_icon_state = "none")
	update_all_blends()
	return .

/mob/living/advanced/npc/dummy/armor
	name = "armored target practice dummy"

/mob/living/advanced/npc/dummy/armor/Initialize()
	. = ..()
	equip_loadout(/loadout/dummy)
	return .

/mob/living/advanced/npc/dummy/armor_heavy
	name = "heavy armored target practice dummy"

/mob/living/advanced/npc/dummy/armor_heavy/Initialize()
	. = ..()
	equip_loadout(/loadout/dummy/heavy)
	return .


/mob/living/advanced/npc/dummy/dead
	dead = TRUE