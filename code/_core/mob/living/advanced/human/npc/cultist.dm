/mob/living/advanced/npc/cultist
	name = "clown cultist"
	starting_factions = list(
		FACTION_PLAYER_HOSTILE
	)
	ai = /ai/

/mob/living/advanced/npc/cultist/tutorial
	name = "strange clown"
	starting_factions = list()
	ai = /ai/



/mob/living/advanced/npc/cultist01
	name = "Nalagaf the Wicked"
	starting_factions = list(
		FACTION_PLAYER_HOSTILE
	)
	ai = /ai/advanced/ranged/wizard
	class = "wizard"

	loot_drop = "wizard"

/mob/living/advanced/npc/cultist01/Initialize()

	. = ..()

	add_outfit("cult")

	pickup(new /obj/item/weapon/ranged/magic/staff/basic(src.loc),FALSE)
	pickup(new /obj/item/weapon/ranged/magic/tome/lightning(src.loc),TRUE)

	return .