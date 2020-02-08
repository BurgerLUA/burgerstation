/mob/living/advanced/npc/clown
	name = "clown"
	starting_factions = list(
		FACTION_PLAYER_HOSTILE
	)

	loot_drop = "clown"

	ai = /ai/advanced/ranged

/mob/living/advanced/npc/clown/Initialize()

	. = ..()

	add_outfit("clown")
	put_in_hands(new /obj/item/weapon/ranged/magic/staff/chaos(src.loc),FALSE)

	return .




/mob/living/advanced/npc/clown/tutorial
	name = "strange clown"
	starting_factions = list()



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

	put_in_hands(new /obj/item/weapon/ranged/magic/staff/basic(src.loc),FALSE)
	put_in_hands(new /obj/item/weapon/ranged/magic/tome/lightning(src.loc),TRUE)

	return .