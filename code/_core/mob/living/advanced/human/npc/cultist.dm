/mob/living/advanced/npc/clown
	name = "clown"

	loot_drop = "clown"

	ai = /ai/advanced/ranged

/mob/living/advanced/npc/clown/Initialize()

	. = ..()

	equip_loadout("clown")
	put_in_hands(new /obj/item/weapon/ranged/magic/staff/chaos(src.loc),FALSE)

	return .




/mob/living/advanced/npc/clown/tutorial
	name = "strange clown"

/mob/living/advanced/npc/cultist01
	name = "Nalagaf the Wicked"
	ai = /ai/advanced/ranged/wizard
	class = "wizard"

	loot_drop = "wizard"

/mob/living/advanced/npc/cultist01/Initialize()

	. = ..()

	equip_loadout("cult")

	put_in_hands(new /obj/item/weapon/ranged/magic/staff/basic(src.loc),FALSE)
	put_in_hands(new /obj/item/weapon/ranged/magic/tome/lightning(src.loc),TRUE)

	return .