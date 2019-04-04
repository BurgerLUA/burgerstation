/mob/living/advanced/human/npc/evil_wizard
	name = "Merlin"
	starting_factions = list(
		FACTION_PLAYER_HOSTILE
	)
	ai = /ai/wizard
	class = "wizard"

	loot_drop = "wizard"

/mob/living/advanced/human/npc/evil_wizard/Initialize()

	. = ..()

	change_organ_visual("hair_face", desired_color = "#FFFFFF", desired_icon = 'icons/mob/living/advanced/hair/face.dmi', desired_icon_state = "facial_wise_s")
	add_outfit("wizard")


	pickup(new /obj/item/weapon/ranged/magic/staff/basic(src.loc),FALSE)
	pickup(new /obj/item/weapon/ranged/magic/tome/lightning(src.loc),TRUE)

	return .