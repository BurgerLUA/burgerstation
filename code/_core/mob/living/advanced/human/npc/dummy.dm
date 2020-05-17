/mob/living/advanced/npc/dummy
	name = "target practice dummy"
	ai = null
	class = "passive"
	species = "dummy"

	immortal = TRUE

	spawn_blood = FALSE

	health_base = 1000

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

	equip_loadout("dummy_armor")

	return .