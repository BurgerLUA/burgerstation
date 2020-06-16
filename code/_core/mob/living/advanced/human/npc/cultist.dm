/mob/living/advanced/npc/clown
	name = "clown"


	ai = /ai/advanced/ranged

/mob/living/advanced/npc/clown/Initialize()

	. = ..()

	equip_loadout(/loadout/clown/)
	put_in_hands(new /obj/item/weapon/ranged/magic/staff/chaos(src.loc),FALSE)

	return .




/mob/living/advanced/npc/clown/tutorial
	name = "strange clown"

/mob/living/advanced/npc/cultist01
	name = "Nalagaf the Wicked"
	ai = /ai/advanced/ranged/wizard
	class = /class/wizard/


/mob/living/advanced/npc/cultist01/Initialize()

	. = ..()

	equip_loadout(/loadout/cultist/)

	put_in_hands(new /obj/item/weapon/ranged/magic/staff/basic(src.loc),FALSE)
	put_in_hands(new /obj/item/weapon/ranged/magic/tome/lightning(src.loc),TRUE)

	return .