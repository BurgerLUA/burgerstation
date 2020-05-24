/mob/living/advanced/npc/evil_wizard
	name = "Merlin"
	id = "merlin"
	ai = /ai/advanced/ranged/
	class = "wizard"

	force_spawn = TRUE
	boss = TRUE

/mob/living/advanced/npc/evil_wizard/Initialize()

	. = ..()

	change_organ_visual("hair_face", desired_color = "#FFFFFF", desired_icon_state = "facial_wise_s")
	update_all_blends()
	equip_loadout("wizard_evil")

	put_in_hands(new /obj/item/weapon/ranged/magic/staff/basic(src.loc),FALSE)
	put_in_hands(new /obj/item/weapon/ranged/magic/tome/lightning(src.loc),TRUE)

	return .