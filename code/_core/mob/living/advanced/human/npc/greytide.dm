/mob/living/advanced/human/npc/greytide
	name = "greytide"
	enable_AI = TRUE
	starting_factions = list(
		FACTION_PLAYER_HOSTILE
	)
	//ai = /ai/greytide/
	mob_outfit = /outfit/assistant

/mob/living/advanced/human/npc/greytide/Initialize()

	. = ..()

	var/list/possible_weapons = list(
		/obj/item/weapon/melee/toolbox/red,
		/obj/item/weapon/melee/toolbox/green,
		/obj/item/weapon/melee/toolbox/blue
	)

	var/picked_weapon = pick(possible_weapons)

	var/obj/item/weapon/W = new picked_weapon(src.loc)
	pickup(W)

	return .