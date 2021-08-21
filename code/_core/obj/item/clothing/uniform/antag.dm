/obj/item/clothing/uniform/antag
	name = "player antagonist uniform"
	desc = "Uh oh, salt inbound."
	desc_extended = "Some antagonist uniform worn by antagonist."
	icon = 'icons/obj/item/clothing/uniforms/util_gen.dmi'
	rarity = RARITY_RARE

	item_slot = SLOT_TORSO | SLOT_GROIN

	flags_clothing = FLAG_CLOTHING_NOBEAST_FEET

	defense_rating = list(
		BLADE = 20,
		BLUNT = 20,
		PIERCE = 20,
		COLD = 40,
		HEAT = -20
	)

	value = 50

/obj/item/clothing/uniform/antag/syndicate
	name = "syndicate combat uniform"
	desc = "WHISKEY ECHO WHISKEY"
	desc_extended = "Syndicate combat fatigues worn by high-ranking Syndicate combatants."
	icon = 'icons/obj/item/clothing/uniforms/syndie_antag.dmi'
	value = 250

/obj/item/clothing/uniform/antag/rev
	name = "revolutionary combat uniform"
	desc = "We're not allowed to die, commissar said so."
	desc_extended = "Russian combat fatigues worn by high-ranking Revolutionaries' combatants."
	icon = 'icons/obj/item/clothing/uniforms/rev_antag.dmi'
	value = 250

/obj/item/clothing/uniform/antag/rev/officer
	name = "revolutionary officer uniform"
	desc = "Red terror."
	desc_extended = "Russian officer uniform worn by Revolutionaries' officers."
	icon = 'icons/obj/item/clothing/uniforms/revficer.dmi'
