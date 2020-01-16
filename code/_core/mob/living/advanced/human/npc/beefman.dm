/mob/living/advanced/npc/beefman
	name = "anomaly"
	enable_AI = TRUE
	starting_factions = list(
		FACTION_PLAYER_HOSTILE
	)
	ai = /ai/advanced/ashwalker
	species = "beefman"
	class = "ashwalker"

/mob/living/advanced/npc/beefman/Initialize()

	. = ..()

	update_all_blends()

	return .

/mob/living/advanced/npc/borgman
	name = "borgman"
	enable_AI = TRUE
	starting_factions = list(
		FACTION_PLAYER_HOSTILE
	)
	ai = /ai/advanced/ashwalker
	species = "cyborg"
	class = "ashwalker"

/mob/living/advanced/npc/borgman/Initialize()

	. = ..()

	update_all_blends()

	return .
