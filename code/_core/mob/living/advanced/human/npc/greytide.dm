/mob/living/advanced/npc/greytide
	name = "feral greytider"
	enable_AI = TRUE
	starting_factions = list(
		FACTION_PLAYER_HOSTILE
	)
	ai = /ai/advanced/
	class = "ashwalker"

/mob/living/advanced/npc/greytide/Initialize()

	. = ..()

	change_organ_visual("skin", desired_color = "#FFBAA3")
	change_organ_visual("hair_head", desired_color = "#9E7E6E", desired_icon_state = "hair_a")
	update_all_blends()

	add_outfit("shopkeeper_outfit")

	return .